Message-ID: <37342C2B.E435F291@wanadoo.fr>
Date: Sat, 08 May 1999 14:20:59 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Tom Rini <tmrini@ntplx.net>
Subject: [BUG] in glibc-2.1.1-6b: gethostbyname broken
Content-Type: multipart/mixed;
 boundary="------------13EDBE9E5C97C5D9B5061AB1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------13EDBE9E5C97C5D9B5061AB1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Under glibc-2.1.1-6b, I cannot do an NFS-mount using the numeric IP
address of the server. Without even consulting the net, mount says:
  mount: can't get address for xx.xx.xx.xx

Under glibc-2.1.1-5b, it works correctly.

I tracked this down to gethostbyname, which doesn't work correctly when
fed a numeric IP address.

If I run the the attached program as
 tstgethbn 193.252.19.78 
I get a correct result when glibc-2.1.1-5b.ppc.rpm is installed, and an
error when glibc-2.1.1-6b.ppc.rpm is installed. Both rpms are from
mirror.linuxppc.org.

Could someone who knows what changed between 5b and 6b please look into
this?

Martin
--------------13EDBE9E5C97C5D9B5061AB1
Content-Type: text/plain; charset=us-ascii;
 name="tstgethbn.c"
Content-Disposition: inline;
 filename="tstgethbn.c"
Content-Transfer-Encoding: 7bit

/* tstgethbn.c
   Test for gesthostbyname */

#include <stdio.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
 
int main(int argc, char** argv)
{
   char hostname[65];
   struct hostent *he = NULL;
   struct hostent *he2 = NULL;
   extern int h_errno;
 
   strcpy(hostname, argv[1]);
   printf( " Looking up %s\n", hostname );
 
   he = gethostbyname(hostname);
   if ( h_errno ) {
       printf(" error %d\n", h_errno);
       herror(hostname);
   } 

   if ( he == NULL ){
       printf("No hostname found\n");
      exit(1);
   }

    printf( "\t      Hostname: %s\n", he->h_name );
 
   if ( he->h_addr_list[0] != NULL )
     printf("\t       Address: %s \n", 
	    inet_ntoa(*(struct in_addr *) he->h_addr_list[0]));

   he2 = gethostbyaddr( he->h_addr_list[0], he->h_length, he->h_addrtype );
   printf( "\t          Name: %s\n", he2->h_name );

   exit(0);
}
  

--------------13EDBE9E5C97C5D9B5061AB1--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
