Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy02.edpnet.net (lmailproxy02.edpnet.net [212.71.1.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6684DDF11
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 04:06:44 +1000 (EST)
Date: Thu, 28 Jun 2007 20:06:32 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.4/2.6/ppc/powerpc/8245/8347e
Message-ID: <20070628180632.GA2660@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <20070621171340.GS5417@chiana.homelinux.org>
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--5I6of5zJg18YgZEa
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

a small update:

> 8245: 2.4.34
> 8237e: 2.6.21.1

I've tried the following setup:
multicast stream @8192 kbps, one process taking in and dumping the data
on each board [1].

a) 8245/2.4.34/e100: 2.3.43-k1, @400 MHz
b) 8245/2.6.17/e100: 2.3.43-k1 [2] @350 MHz
c) 8347e/2.6.21.1/gianfar @400 Mhz
c) XScale-IXP42x/2.6.18-4/ixp4xx @266 MHz (NSLU2)

(2.3.43-k1 is the e100 driver version).

The process load for taking in the data is:

a) 4-5% [3]
b) 10-11%
c) 13-14%
d) 4-5%

While the current 8347/gianfar platform is the worst performer, the
2.6 kernel with the 2.4 e100 (before the rewrite) seems to perform
poorly too [4].

So the 834x preforms worse wrt the 8245 based configuration even though
it is slightly higher clocked.

It seems as if I bumped into the problem that lead me stick with the 2.4
in the first place for this 8245 platform; but never got round to
investigating. I find these results especially intriguing when
considering an ARM platform (NSLU2 device) that I had around, clocked at
only 66% of the 8347 and at 80% of the 8245 performs certainly in par
with the last one...

Even though I will need to recheck this (results to follow), a quick
test didn't reveal any significant difference between a ppc and powerpc
arch in the kernel.

It does look like, on our 8245/83xx platforms, the 2.6.x kernel performs
worse wrt the 2.4 ppc kernels and the 83xx configuration is worse wrt
the 8245 based configuration [5]. In retrospect, we had signals that
there was a problem with the 8245/83xx performance over the network last
year when investigating gstreamer, but due to time pressure but assumed
it was due to gstreamer and not the processor. This came as a suprise to
some of the ppl on the gstreamer mailing list that reported performant
ports to ARM architectures.

The results with the NSLU2 will certainly put heat on us from management
when redesigning or for follow up designs :(

Anyhow, I'm currently extending my test setups since this is an
important problem and set back.

If anyone has a hint to explaining what is going on here, please do
since solving this will certainly beat redesigning (esp. considering the
timeframe we've been assigned).


I've only found one relevant reference to 2.4/2.6 network performance
decrease at this point [6].


[1] sources attached
    mcrecv -p 225.1.2.3 -a 12345
    mcsend -p 225.1.2.3 -a 12345 -b 8192
    I'm preparing more tests in the next days, in trying to figure out
    what really is going on here.
[2] 2.4 driver ported to 2.6 kernel.
[3] This figure is read from top and not from the app since it seems to
    be an underestimate (./fs/proc/array.c).
[4] I believe I ported the 2.4 e100 to the 2.6 2 years ago because it
performed much better, but I'll verify that in the next days.
[5] Obviously, testing 834x against the 2.4 kernel is not really an
option  :)
[6] http://www.mail-archive.com/linux-net@vger.kernel.org/msg01283.html

--=20
  greetz, marc
Don't think I'm going to miss you, any of you. I'm not. Well, maybe
a little bit.
	Rygel - Into the Lion's Den - Wolf in Sheep's Clothing
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--DocE+STaALJfprDB
Content-Type: text/x-csrc; charset=iso-8859-15
Content-Disposition: attachment; filename="recv_mcast.c"
Content-Transfer-Encoding: quoted-printable

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include <time.h>

#define BUFSIZE 64*1024 /*  Maximal packet content is 64k bytes */
#define MAXPARAMLEN 80
#define STATFILE "/proc/stat"
#define SELFSTATFILE "/proc/self/stat"

void error(char *msg);

void usage(const char* program)
{
	fprintf(stdout,"usage : %s -a address -p port\n",program);
}

float getsysload()
{
	unsigned long user =3D 0ul, nice =3D 0ul, system =3D 0ul, idle =3D 0ul;
	char buf[BUFSIZ];
	FILE *fp;
	char buffer[BUFSIZ];

	memset(buffer,0x0,BUFSIZ);

	if((fp=3Dfopen(STATFILE,"r"))<=3D0){
		fprintf(stderr, "Problem opening %s\n", STATFILE);
		return EXIT_FAILURE;
	}

	fread(buffer, sizeof(char), BUFSIZ, fp);

	fclose(fp);

	if(sscanf(buffer,"%s %lu %lu %lu %lu",buf, &user, &nice, &system, &idle)){
		return (float)(user+system)/(user+system+nice+idle);
	}
	else{
		fprintf(stdout, "no matching strings found\n");
	}

}

unsigned long getcurrjiffies()
{
	FILE *fp;
	char buffer[BUFSIZ];

	memset(buffer, 0x0, BUFSIZ);

	fp=3Dpopen("cat /proc/self/stat | cut -d \\  -f 22","r");

	fread(buffer, sizeof(char), BUFSIZ, fp);

	pclose(fp);

	return atoi(buffer);
}

unsigned long scan_stat(unsigned long *user, unsigned long *kernel)
{
	FILE *fp;
	char buffer[BUFSIZ];

	uint32_t scanned =3D 0u;
	signed int pid =3D 0;
	char tcomm[BUFSIZ];
	char state =3D 0x0;
	signed int ppid =3D 0;
	signed int pgid =3D 0;
	signed int sid =3D 0;
	signed int tty_nr =3D 0;
	signed int tty_pgrp =3D 0;
	unsigned long flags =3D 0ul;
	unsigned long min_flt =3D 0ul;
	unsigned long cmin_flt =3D 0ul;
	unsigned long maj_flt =3D 0ul;
	unsigned long cmaj_flt =3D 0ul;
	unsigned long utime =3D 0ul;
	unsigned long stime =3D 0ul;
	signed long cutime =3D 0l;
	signed long cstime =3D 0l;
	signed long priority =3D 0l;
	signed long nice =3D 0l;
	signed int num_threads =3D 0;
	unsigned long long start_time =3D 0ul;
	unsigned long vsize =3D 0ul;
	signed long rss =3D 0l;
	unsigned long rsslim =3D 0ul;
	unsigned long start_code =3D 0ul;
	unsigned long end_code =3D 0ul;
	unsigned long start_stack =3D 0ul;
	unsigned long esp =3D 0ul;
	unsigned long eip =3D 0ul;
	/* The signal information here is obsolete.
	 * It must be decimal for Linux 2.0 compatibility.
	 * Use /proc/#/status for real-time signals.
	 */
	unsigned long signalpending =3D 0ul;
	unsigned long signalblocked =3D 0ul;
	unsigned long sigign =3D 0ul;
	unsigned long sigcatch =3D 0ul;
	unsigned long wchan =3D 0ul;
	unsigned long dummy0 =3D 0ul;
	unsigned long dummy1 =3D 0ul;
	int exit_signal =3D 0;
	int task_cpu =3D 0;
	unsigned long rt_priority =3D 0ul;
	unsigned long policy =3D 0ul;
	unsigned long long delayticks =3D 0ull;


	memset(buffer,0x0,BUFSIZ);
	memset(tcomm,0x0,BUFSIZ);

	if(!(fp=3Dfopen(SELFSTATFILE,"r"))){
		fprintf(stderr,"Error opening \"%s\".\n",SELFSTATFILE);
		return 0;
	}

	fread(buffer, sizeof(char), BUFSIZ, fp);

	fclose(fp);
#if 0
	fprintf(stdout,"Reference:\n");
	fprintf(stdout,"-------\n");
	fprintf(stdout,"%s\n",buffer);
	fprintf(stdout,"-------\n");
#endif

	scanned =3D sscanf(buffer,"%d %s %c %d %d %d %d %d %lu %lu \
			%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %l=
u \
			%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
			&pid,
			tcomm,
			&state,
			&ppid,
			&pgid,
			&sid,
			&tty_nr,
			&tty_pgrp,
			&flags,
			&min_flt,
			&cmin_flt,
			&maj_flt,
			&cmaj_flt,
			&utime,
			&stime,
			&cutime,
			&cstime,
			&priority,
			&nice,
			&num_threads,
			&start_time,
			&vsize,
			&rss,
			&rsslim,
			&start_code,
			&end_code,
			&start_stack,
			&esp,
			&eip,
			/* The signal information here is obsolete.
			 * It must be decimal for Linux 2.0 compatibility.
			 * Use /proc/#/status for real-time signals.
			 */
			&signalpending,
			&signalblocked,
			&sigign,
			&sigcatch,
			&wchan,
			&dummy0,
			&dummy1,
			&exit_signal,
			&task_cpu,
			&rt_priority,
			&policy,
			&delayticks);

#if 0
	fprintf(stdout,"scanned %u items.\n",scanned);
	fprintf(stdout,"%d %s %c %d %d %d %d %d %lu %lu \
			%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %l=
u \
			%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
			pid,
			tcomm,
			state,
			ppid,
			pgid,
			sid,
			tty_nr,
			tty_pgrp,
			flags,
			min_flt,
			cmin_flt,
			maj_flt,
			cmaj_flt,
			utime,
			stime,
			cutime,
			cstime,
			priority,
			nice,
			num_threads,
			start_time,
			vsize,
			rss,
			rsslim,
			start_code,
			end_code,
			start_stack,
			esp,
			eip,
			/* The signal information here is obsolete.
			 * It must be decimal for Linux 2.0 compatibility.
			 * Use /proc/#/status for real-time signals.
			 */
			signalpending,
			signalblocked,
			sigign,
			sigcatch,
			wchan,
			dummy0,
			dummy1,
			exit_signal,
			task_cpu,
			rt_priority,
			policy,
			delayticks);
#endif
	*user =3D utime;
	*kernel =3D stime;
	return utime + stime;
}

int main(int argc, char *argv[])=20
{
	extern int getopt();
	extern int optind;
	extern char *optarg;
	int c_opt;

	int socket_val, bind_val, recvfromval, ctrlboardlen,
	    rc, recvbuff;
	unsigned optlen, cameralen;
	uint16_t mc_port;
	char mc_addr[16];
	struct ip_mreq mreq;
	struct sockaddr_in ctrlboard, camera;
	struct in_addr mcast_address;
	struct hostent *h;
	unsigned char buffer[BUFSIZE];
	FILE *fp;
	uint32_t ucnt =3D 0u,i,cnt=3D0u;
	uint64_t usecs[8];
	uint64_t received[8];
	uint64_t treceived =3D 0ul;

	struct timeval newtime;

	unsigned long p_jiffies, c_jiffies;
	unsigned long puser, pkernel;
	unsigned long cuser, ckernel;
	unsigned long long p_start, c_start;

	/*  Initialize the buffer */
        memset(mc_addr, 0x0, 16);
	memset(buffer,0x0,BUFSIZE);

	for(i=3D0;i<8;i++){
		usecs[i] =3D 0ul;
		received[8] =3D 0ul;
	}

	/* handling of command line options */
	while ((c_opt =3D getopt(argc, argv, "a:b:p:")) !=3D EOF) {
		switch (c_opt) {
			case 'a':
				strncpy(mc_addr,optarg,16);
				break;
			case 'p':
				mc_port =3D (atoi(optarg));
				break;
			default:
				fprintf(stderr, "%s: Bad Option -%c\n", argv[0], c_opt);
				exit(EXIT_FAILURE);
		}
	}

	if(!mc_addr || !mc_port){
		usage(argv[0]);
		return EXIT_FAILURE;
	}

	/*  Get mcast address to listen to  */
	h=3Dgethostbyname(mc_addr);
	if(h=3D=3DNULL) {
		fprintf(stdout,"Unknown group %s\n",mc_addr);
		exit(1);
	}

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
	ctrlboard.sin_port=3Dhtons(mc_port);

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

	/*  Bind to associate port number with the socket */
	bind_val =3D bind(socket_val,(struct sockaddr *)&ctrlboard,ctrlboardlen);
	if (bind_val < 0)
		error("Error bind");

	/* join multicast group */
	mreq.imr_multiaddr.s_addr=3Dmcast_address.s_addr;
	mreq.imr_interface.s_addr=3Dhtonl(INADDR_ANY);

	rc =3D setsockopt(socket_val,IPPROTO_IP,IP_ADD_MEMBERSHIP, (void *) &mreq,=
 sizeof(mreq));
	if(rc<0){
		fprintf(stdout,"Cannot join multicast group '%s'", inet_ntoa(mcast_addres=
s));
		exit(1);
	}
	else
		fprintf(stdout,"Listening to mgroup %s:%d\n", inet_ntoa(mcast_address), m=
c_port);

	/*  Fill in length of struct sockaddr_in camera */
	cameralen =3D sizeof(camera);

	gettimeofday(&newtime,NULL);
	p_jiffies =3D scan_stat(&puser, &pkernel);
	p_start =3D getcurrjiffies();
	/*  Loop */
	while (1) {
		recvfromval =3D recvfrom(socket_val,buffer,BUFSIZE,0,(struct sockaddr *)&=
camera,&cameralen);
		treceived +=3D recvfromval;

		if (recvfromval < 0) error("Error recvfrom");

		if(!(cnt&0xff)){
			double cbitrate =3D 0.0;
			uint8_t ccnt =3D ucnt&0x7;
			uint8_t pcnt =3D ccnt?ccnt-1:0x7;
			uint64_t dt;

			c_jiffies =3D scan_stat(&cuser,&ckernel);
			c_start =3D getcurrjiffies();

			gettimeofday(&newtime,NULL);
			usecs[ccnt] =3D (uint64_t)(newtime.tv_sec*1e6+newtime.tv_usec);
			received[ccnt] =3D treceived;

			dt =3D usecs[ccnt] - usecs[pcnt];

			if(usecs[ccnt]<usecs[pcnt]){
				ucnt =3D 0;
			}
			else{
				unsigned lcnt =3D 0u;
				for(i=3D0;i<8;i++){
					lcnt =3D received[i];
				}
				if(dt){
					cbitrate =3D (((double)lcnt*8)/((double)dt))*1e3;

					fprintf(stdout,"Approx bitrate is %2.2lf kbps, system load is %2.2f%%,=
 process %2.2f%% (u %2.2f%%, s %2.2f).\n",=20
							cbitrate,=20
							getsysload()*100,
							(double)(c_jiffies - p_jiffies)*100/(c_start - p_start),
							(double)(cuser-puser)*100/(c_start - p_start),
							(double)(ckernel-pkernel)*100/(c_start - p_start)
						);
				}
			}
			ucnt++;
			treceived =3D 0;
			p_jiffies =3D c_jiffies;
			p_start =3D c_start;
			pkernel =3D ckernel;
			puser =3D cuser;
		}
		cnt++;
	}

	close(socket_val);
	fclose(fp);
}

void error(char *msg) {

  perror(msg);
  exit(0);
}


--DocE+STaALJfprDB
Content-Type: text/x-csrc; charset=iso-8859-15
Content-Disposition: attachment; filename="send_mcast.c"
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <netdb.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>

#define STATFILE "/proc/stat"
#define SELFSTATFILE "/proc/self/stat"

void usage(const char* program)
{
	fprintf(stdout,"Usage: %s -a address -p port -b bitrate\n",program);
	fprintf(stdout,"	bitrate in kbps.\n");
}

float getsysload()
{
	unsigned long user =3D 0ul, nice =3D 0ul, system =3D 0ul, idle =3D 0ul;
	char buf[BUFSIZ];
	FILE *fp;
	char buffer[BUFSIZ];

	memset(buffer,0x0,BUFSIZ);

	if((fp=3Dfopen(STATFILE,"r"))<=3D0){
		fprintf(stderr, "Problem opening %s\n", STATFILE);
		return EXIT_FAILURE;
	}

	fread(buffer, sizeof(char), BUFSIZ, fp);

	fclose(fp);

	if(sscanf(buffer,"%s %lu %lu %lu %lu",buf, &user, &nice, &system, &idle)){
		return (float)(user+system)/(user+system+nice+idle);
	}
	else{
		fprintf(stdout, "no matching strings found\n");
	}

}

unsigned long getcurrjiffies()
{
	FILE *fp;
	char buffer[BUFSIZ];

	memset(buffer, 0x0, BUFSIZ);

	fp=3Dpopen("cat /proc/self/stat | cut -d \\  -f 22","r");

	fread(buffer, sizeof(char), BUFSIZ, fp);

	pclose(fp);

	return atoi(buffer);
}

unsigned long scan_stat(unsigned long *user, unsigned long *kernel)
{
	FILE *fp;
	char buffer[BUFSIZ];

	uint32_t scanned =3D 0u;
	signed int pid =3D 0;
	char tcomm[BUFSIZ];
	char state =3D 0x0;
	signed int ppid =3D 0;
	signed int pgid =3D 0;
	signed int sid =3D 0;
	signed int tty_nr =3D 0;
	signed int tty_pgrp =3D 0;
	unsigned long flags =3D 0ul;
	unsigned long min_flt =3D 0ul;
	unsigned long cmin_flt =3D 0ul;
	unsigned long maj_flt =3D 0ul;
	unsigned long cmaj_flt =3D 0ul;
	unsigned long utime =3D 0ul;
	unsigned long stime =3D 0ul;
	signed long cutime =3D 0l;
	signed long cstime =3D 0l;
	signed long priority =3D 0l;
	signed long nice =3D 0l;
	signed int num_threads =3D 0;
	unsigned long long start_time =3D 0ul;
	unsigned long vsize =3D 0ul;
	signed long rss =3D 0l;
	unsigned long rsslim =3D 0ul;
	unsigned long start_code =3D 0ul;
	unsigned long end_code =3D 0ul;
	unsigned long start_stack =3D 0ul;
	unsigned long esp =3D 0ul;
	unsigned long eip =3D 0ul;
	/* The signal information here is obsolete.
	 * It must be decimal for Linux 2.0 compatibility.
	 * Use /proc/#/status for real-time signals.
	 */
	unsigned long signalpending =3D 0ul;
	unsigned long signalblocked =3D 0ul;
	unsigned long sigign =3D 0ul;
	unsigned long sigcatch =3D 0ul;
	unsigned long wchan =3D 0ul;
	unsigned long dummy0 =3D 0ul;
	unsigned long dummy1 =3D 0ul;
	int exit_signal =3D 0;
	int task_cpu =3D 0;
	unsigned long rt_priority =3D 0ul;
	unsigned long policy =3D 0ul;
	unsigned long long delayticks =3D 0ull;


	memset(buffer,0x0,BUFSIZ);
	memset(tcomm,0x0,BUFSIZ);

	if(!(fp=3Dfopen(SELFSTATFILE,"r"))){
		fprintf(stderr,"Error opening \"%s\".\n",SELFSTATFILE);
		return 0;
	}

	fread(buffer, sizeof(char), BUFSIZ, fp);

	fclose(fp);
#if 0
	fprintf(stdout,"Reference:\n");
	fprintf(stdout,"-------\n");
	fprintf(stdout,"%s\n",buffer);
	fprintf(stdout,"-------\n");
#endif

	scanned =3D sscanf(buffer,"%d %s %c %d %d %d %d %d %lu %lu \
			%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %l=
u \
			%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
			&pid,
			tcomm,
			&state,
			&ppid,
			&pgid,
			&sid,
			&tty_nr,
			&tty_pgrp,
			&flags,
			&min_flt,
			&cmin_flt,
			&maj_flt,
			&cmaj_flt,
			&utime,
			&stime,
			&cutime,
			&cstime,
			&priority,
			&nice,
			&num_threads,
			&start_time,
			&vsize,
			&rss,
			&rsslim,
			&start_code,
			&end_code,
			&start_stack,
			&esp,
			&eip,
			/* The signal information here is obsolete.
			 * It must be decimal for Linux 2.0 compatibility.
			 * Use /proc/#/status for real-time signals.
			 */
			&signalpending,
			&signalblocked,
			&sigign,
			&sigcatch,
			&wchan,
			&dummy0,
			&dummy1,
			&exit_signal,
			&task_cpu,
			&rt_priority,
			&policy,
			&delayticks);

#if 0
	fprintf(stdout,"scanned %u items.\n",scanned);
	fprintf(stdout,"%d %s %c %d %d %d %d %d %lu %lu \
			%lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %l=
u \
			%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
			pid,
			tcomm,
			state,
			ppid,
			pgid,
			sid,
			tty_nr,
			tty_pgrp,
			flags,
			min_flt,
			cmin_flt,
			maj_flt,
			cmaj_flt,
			utime,
			stime,
			cutime,
			cstime,
			priority,
			nice,
			num_threads,
			start_time,
			vsize,
			rss,
			rsslim,
			start_code,
			end_code,
			start_stack,
			esp,
			eip,
			/* The signal information here is obsolete.
			 * It must be decimal for Linux 2.0 compatibility.
			 * Use /proc/#/status for real-time signals.
			 */
			signalpending,
			signalblocked,
			sigign,
			sigcatch,
			wchan,
			dummy0,
			dummy1,
			exit_signal,
			task_cpu,
			rt_priority,
			policy,
			delayticks);
#endif
	*user =3D utime;
	*kernel =3D stime;
	return utime + stime;
}

int main(int argc, char *argv[])
{
	extern int getopt();
	extern int optind;
	extern char *optarg;
	int c_opt;

	unsigned int mc_server_socket;
	struct sockaddr_in mc_addr_sockaddr;

	uint8_t TTL =3D 0u;
	uint8_t buffer[BUFSIZ];
	int retval;
	uint16_t mc_port =3D 0u;
	char mc_addr[16];
	uint32_t mc_bitrate =3D 0u, i, cnt =3D 0u, ucnt=3D0u;
	float delay =3D 0;
	unsigned long usecs[8];

	unsigned long p_jiffies, c_jiffies;
	unsigned long puser, pkernel;
	unsigned long cuser, ckernel;
	unsigned long long p_start, c_start;

	struct timeval newtime;

	/* Init */
	memset(mc_addr, 0x0, 16);
	for(i=3D0;i<8;i++){
		usecs[i] =3D 0ul;
	}
	for(i=3D0;i<BUFSIZ>>2;i++){
		((uint32_t*)buffer)[i]=3D0xbadc0ffe;
	}


	/* handling of command line options */
	while ((c_opt =3D getopt(argc, argv, "a:b:p:")) !=3D EOF) {
		switch (c_opt) {
			case 'a':
				strncpy(mc_addr,optarg,16);
				break;
			case 'b':
				mc_bitrate =3D (atoi(optarg));
				break;
			case 'p':
				mc_port =3D (atoi(optarg));
				break;
			default:
				fprintf(stderr, "%s: Bad Option -%c\n", argv[0], c_opt);
				exit(EXIT_FAILURE);
		}
	}

	if(!mc_addr || !mc_port || !mc_bitrate){
		usage(argv[0]);
		return EXIT_FAILURE;
	}

	/* Create a multicast socket */
	mc_server_socket=3Dsocket(AF_INET, SOCK_DGRAM,0);

	/* Create multicast group address information */
	mc_addr_sockaddr.sin_family =3D AF_INET;
	mc_addr_sockaddr.sin_addr.s_addr =3D inet_addr(mc_addr);
	mc_addr_sockaddr.sin_port =3D htons(mc_port);

	/* Set the TTL for the sends using a setsockopt() */
	TTL =3D 1;
	retval =3D setsockopt(mc_server_socket, IPPROTO_IP, IP_MULTICAST_TTL, (cha=
r *)&TTL, sizeof(TTL));
	if (retval < 0){
		fprintf(stdout,"ERROR setsockopt() failed with %d \n", retval);
		return EXIT_FAILURE;
	}

	/* get estimated us delay */
	delay =3D 1e6/((float)(mc_bitrate<<10)/(sizeof(buffer)<<3));

	/* Send MC message */
	fprintf(stdout,"Multicast to socket %s:%u.\n",mc_addr, mc_port);
	fprintf(stdout,"Requested bitrate is %u kbps.\n",mc_bitrate);
	fprintf(stdout,"Need %2.2f packets of %u bytes per second.\n",((float)(mc_=
bitrate<<10)/(sizeof(buffer)<<3)),sizeof(buffer));
	fprintf(stdout,"Setting interpacket delay at %2.2f usec.\n",delay);

	gettimeofday(&newtime,NULL);
	p_jiffies =3D scan_stat(&puser, &pkernel);
	p_start =3D getcurrjiffies();
	// usecs[ucnt++] =3D newtime.tv_sec*1e6+newtime.tv_usec;
	while(1){
		/* Send buffer as a datagram to the multicast group */
		sendto(mc_server_socket, buffer, sizeof(buffer), 0,
				(struct sockaddr*)&mc_addr_sockaddr, sizeof(mc_addr_sockaddr));
		usleep(delay);

		if(!(cnt&0xff)){
			double cbitrate =3D 0.0;
			uint8_t ccnt =3D ucnt&0x7;
			uint8_t pcnt =3D ccnt?ccnt-1:0x7;
			unsigned long dt;

			c_jiffies =3D scan_stat(&cuser,&ckernel);
			c_start =3D getcurrjiffies();

			gettimeofday(&newtime,NULL);
			usecs[ccnt] =3D newtime.tv_sec*1e6+newtime.tv_usec;
			dt =3D usecs[ccnt] - usecs[pcnt];

			if(usecs[ccnt]<usecs[pcnt]){
				ucnt =3D 0;
			}
			else{
				cbitrate =3D ((((double)sizeof(buffer)*8)*0xff)/((float)dt))*1e3;

				fprintf(stdout,"Approx bitrate is %2.2lf kbps, system load is %2.2f%%, =
process %2.2f%% (u %2.2f%%, s %2.2f).\n",=20
						cbitrate,=20
						getsysload()*100,
						(double)(c_jiffies - p_jiffies)*100/(c_start - p_start),
						(double)(cuser-puser)*100/(c_start - p_start),
						(double)(ckernel-pkernel)*100/(c_start - p_start)
				       );

				if(((cbitrate+256)<mc_bitrate)){
					delay -=3D 500;
					fprintf(stdout,"Interpacket delay adjusted to %2.2f usec\n",delay);
				}
				else if ((cbitrate-256)>mc_bitrate){
					delay +=3D 500;
					fprintf(stdout,"Interpacket delay adjusted to %2.2f usec\n",delay);
				}

				if(delay<0){
					fprintf(stderr,"Cannot send data out fast enough.\n");
					mc_bitrate -=3D 1024;
					delay =3D 0;
					fprintf(stdout,"Limiting data to %u kbps.\n",mc_bitrate);
				}
				ucnt++;
			}
			p_jiffies =3D c_jiffies;
			p_start =3D c_start;
			pkernel =3D ckernel;
			puser =3D cuser;
		}
		cnt++;
	}

	/* Close and clean-up */
	close(mc_server_socket);

	return EXIT_SUCCESS;
}

--DocE+STaALJfprDB--

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGg/ioUQpj09NWLeERAuRdAKDfl2xSvTInHCqmvi39w0Jf4647XgCgo3Dt
NW29ml/FKjdU/Tru+zFgu3E=
=4m/H
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
