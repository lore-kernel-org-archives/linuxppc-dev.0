Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy01.edpnet.net (lmailproxy01.edpnet.net [212.71.1.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9398FDDEBC
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 00:15:27 +1000 (EST)
Received: from chiana.homelinux.org (213.219.137.187.adsl.dyn.edpnet.net
	[213.219.137.187])
	by lmailproxy01.edpnet.net (8.13.1/8.13.1) with ESMTP id l5LEHBSQ013749
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 16:17:11 +0200
Received: from marc by chiana.homelinux.org with local (Exim 4.63)
	(envelope-from <marc.leeman@gmail.com>) id 1I1NRQ-0003gw-7f
	for linuxppc-dev@ozlabs.org; Thu, 21 Jun 2007 16:15:20 +0200
Date: Thu, 21 Jun 2007 16:15:19 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: network load 8245 vs. 8347E
Message-ID: <20070621141519.GQ5417@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--vru7fAags9pVPvn5
Content-Type: multipart/mixed; boundary="3sseE1tnmEs+TkKq"
Content-Disposition: inline


--3sseE1tnmEs+TkKq
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok, I guess it's comparing apples to lemons here, but I'll have a go at
it anyway.

I'm trying to figure out why partial network decoding on an 8347E is
disappointingly slow wrt an older 8245 processor.

When simply receiving (cf. att) a multicast stream of 12 Mbps, an
8245/uclibc 0.9.28 @350 MHz, ppc arch , the system runs smoothly at a
load of around 4% on a e100 based MAC (pci:  8086:1209 ).

When doing the same thing on 8347e/0.9.28 @400 Mhz, powerpc arch, the
system is loaded at around 34%.

any clues?


This program just takes in data and does nothing with it, to limit the
search area :)

--=20
  greetz, marc
You know until today, I never really realized how much I love my feet.
	Chiana - Vitas Mortis
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--3sseE1tnmEs+TkKq
Content-Type: text/x-csrc; charset=iso-8859-15
Content-Disposition: attachment; filename="recv_mcast.c"
Content-Transfer-Encoding: quoted-printable

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFSIZE 64*1024 /*  Maximal packet content is 64k bytes */
#define MAXPARAMLEN 80

void error(char *msg);

int main(int argc, char *argv[])=20
{
	int socket_val, bind_val, recvfromval, ctrlboardlen, cameralen,
	    i, rc, recvbuff, optlen;
	u_short ctrlboardPort;
	struct ip_mreq mreq;
	struct sockaddr_in ctrlboard, camera;
	struct in_addr mcast_address;
	struct hostent *h;
	unsigned char buffer[BUFSIZE], ctrlboardip[16], sendseq[11];
	FILE *fc,*fp;

	/*  Initialize the buffer */
	bzero(buffer,BUFSIZE);

	if(argc!=3D3) {
		fprintf(stdout,"usage : %s <mcast address> <mcast port>\n",argv[0]);
		exit(0);
	}

	/*  Get mcast address to listen to  */
	h=3Dgethostbyname(argv[1]);
	if(h=3D=3DNULL) {
		fprintf(stdout,"Unknown group %s\n",ctrlboardip);
		exit(1);
	}
	ctrlboardPort=3Datoi(argv[2]);

	memcpy(&mcast_address, h->h_addr_list[0],h->h_length);

	/*  Check given address is multicast  */
	if(!IN_MULTICAST(ntohl(mcast_address.s_addr))) {
		fprintf(stdout,"Given address '%s' is not multicast\n",
				inet_ntoa(mcast_address));
		exit(1);
	}

	/*  Create socket for incoming connections */
	socket_val=3Dsocket(AF_INET, SOCK_DGRAM, 0);
	if (socket_val < 0)
		error("Error opening socket");

	/*  Set content of ctrlboard */
	ctrlboardlen =3D sizeof(ctrlboard);
	bzero(&ctrlboard,ctrlboardlen);

	/*  Fill in the UDP Receiver properties */
	ctrlboard.sin_family=3DAF_INET;
	ctrlboard.sin_addr.s_addr=3Dhtonl(INADDR_ANY);
	ctrlboard.sin_port=3Dhtons(ctrlboardPort);

	/*  Set socket options */
	recvbuff=3D128*1024;
	if (setsockopt(socket_val,SOL_SOCKET,SO_RCVBUF,(char *) &recvbuff, sizeof(=
recvbuff)) < 0)
	error("Error setting socket options");

	/*  Get socket options */
	optlen=3Dsizeof(recvbuff);
	if (getsockopt(socket_val,SOL_SOCKET,SO_RCVBUF,(char *) &recvbuff, &optlen=
) < 0)
	error("Error getting socket options");
	fprintf(stdout,"Receive buffer size: %d \n",recvbuff); =20
=09
	/*  Bind to associate port number with the socket */
	bind_val =3D bind(socket_val,(struct sockaddr *)&ctrlboard,ctrlboardlen);
	if (bind_val < 0)
		error("Error bind");

	/* join multicast group */
	mreq.imr_multiaddr.s_addr=3Dmcast_address.s_addr;
	mreq.imr_interface.s_addr=3Dhtonl(INADDR_ANY);

	rc =3D setsockopt(socket_val,IPPROTO_IP,IP_ADD_MEMBERSHIP, (void *) &mreq,=
 sizeof(mreq));
	if(rc<0)=20
	{
		fprintf(stdout,"Cannot join multicast group '%s'", inet_ntoa(mcast_addres=
s));
		exit(1);
	}
	else
		fprintf(stdout,"Listening to mgroup %s:%d\n", inet_ntoa(mcast_address), c=
trlboardPort);

	/*  Fill in length of struct sockaddr_in camera */
	cameralen =3D sizeof(camera);

	/*  Loop */
	while (1) {
		recvfromval =3D recvfrom(socket_val,buffer,BUFSIZE,0,(struct sockaddr *)&=
camera,&cameralen);
		if (recvfromval < 0) error("Error recvfrom");
	}

	close(socket_val);
	fclose(fp);
}

void error(char *msg) {

  perror(msg);
  exit(0);
}


--3sseE1tnmEs+TkKq--

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGeof3UQpj09NWLeERAnBBAKCyOtCkRR0VHkcjqpYT0STMye8sSQCgk9OO
3RLPRRJZAg9ERcEX/J6YMIU=
=YiSo
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--
