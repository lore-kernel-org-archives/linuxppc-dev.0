Date: Sat, 19 Jun 1999 00:22:01 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Fwd: repeatable 2.2.10 crash (socket() related?)
Message-Id: <19990619002201.007035@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I received this message, if some can help, he may have found a kernel bug...


On Fri, Jun 18, 1999, Ross W. Myers <rmyers@nosc.mil> wrote:

---------------- Begin Forwarded Message ----------------


Hi,

   While perusing the linux-kernel mailing list archives, I came across
   a message of yours regarding 2.2.x kernel problems. (I'm not a kernel
   hacker, and don't subscribe to the mailing list).

   I've been having problems with 2.2.10 while debugging some code of mine.  
   In my attempts to isolate the cause (at the luser, not the kernel,
level :)), 
   I found that a little program (included below) will crash my machine
   every time. Typically, the crashes happen within 10 minutes of
   launching the program. (The crashes seem to happen sooner if I 
   also launch a big application like netscape).  

   This may or may not be related to the problems you've been having,
   but I think it's definitely worth looking into.  Hopefully, some
   other folks can replicate the symptoms I'm seeing.

   I haven't tried this with other 2.2.x kernels, but will do so when I
   have the time.

   Until this problem surfaced, I had been running my machine nearly 24x7
   for over a year with no crashes/flakiness, with both 2.0.x and 2.2.x
   kernels.


   I'm not sure who's the best person to send this to -- Alan Cox,
   Stephen Tweedie, et.al. are probably buried in email, so I'm
   reluctant to add anything else to their in-boxes.  Anyway, if you 
   know of any other folks who'd like to look into this, could you pass
   this message along to them? 

   FWIW, I'm running Debian 2.1 on a single-cpu pentium-II machine.
   If anyone's interested, I can provide more information (.config
   file, ksymoops output, etc..)


                                            --Thanx,

                                                      Ross Myers
                                                      rmyers@nosc.mil   


/************ BEGIN CRASH-O-MATIC CODE  *******************/

#include <errno.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>


#include <stdio.h>
#include <string.h>
#include <unistd.h>
 
#define MYPORT 3008    
#define MYPORTP1 3009

#define BACKLOG 10     

#define MSG_SIZE 4
#define SOCKET_DISCONNECT -1

int main()
{
  int server_sockfd;  
  int server_sockfd2;
  
  int server_socket_setup(int port);
  int client_socket_setup(int server_sockfd);

  while(1) 
  {  
    printf("\n**********UGLY CRASH-O-MATIC**************\n\n");
    printf("\n******************************************\n\n");

    server_sockfd = server_socket_setup(MYPORT);
    server_sockfd2 = server_socket_setup(MYPORTP1);

    close(server_sockfd);
    close(server_sockfd2);
    
  }
  return(0);
  
}

int server_socket_setup(int port)
{
  struct sockaddr_in server_addr;    /* my address information */

  int server_sockfd;
  
  if ((server_sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) 
  {
    perror("socket");
    exit(1);
  }

  server_addr.sin_family = AF_INET;         /* host byte order */
  server_addr.sin_port = htons(MYPORT);     /* short, network byte order */
  server_addr.sin_addr.s_addr = INADDR_ANY; /* auto-fill with my IP */
  bzero(&(server_addr.sin_zero), 8);        /* zero the rest of the struct */

  if (bind(server_sockfd, 
	   (struct sockaddr *)&server_addr, 
	   sizeof(struct sockaddr)) == -1) 
  {
    perror("bind");
    close(server_sockfd);
    return(-1);
  }
  
  if(listen(server_sockfd, BACKLOG) == -1) 
  {
    perror("listen");
    close(server_sockfd);
    return(-1);
  }
  return(server_sockfd);
  
}

/***************END CRASH-O-MATIC CODE ****************************/



-----------------------------------------------------
Brian Feeny (BF304)     signal@shreve.net   
318-222-2638 x 109	http://www.shreve.net/~signal      
Network Administrator   ShreveNet Inc. (ASN 11881) 	      


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/


----------------- End Forwarded Message -----------------

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
