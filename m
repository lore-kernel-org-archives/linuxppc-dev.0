Message-ID: <01C0794B.498EFE70.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: TCP Server stops accepting after 10mins
Date: Mon, 8 Jan 2001 08:16:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone who is working with Redhat EDK 1.0, with its kernel
v2.2.13 and a TCP Server running on an MPC860, ever been able
to have a TCP Client (on another PC) connect at a rate of once every
30s, or more frequently (say, once every 5 secs) , to the TCP Server
for longer than 10 minutes?

Could someone who has this setup please try doing this?
Below are 2 good tests to try.  Both fail at 10 mins on my system.


Test scenario #1, connecting at once every 5s:

On another PC:
Client:   while (1)
               {
               socket()
               connect()
               close()
               5 sec delay        (120 connects in 10 mins)
               }

On Embedded EDK unit:
Server:   socket()
             bind()
             listen()

             while (1)
               {
               accept()
               close()
               }



Test scenario #2, connecting 50 times per sec:

On another PC:
Client:   while (1)
               {
               socket()
               connect()
               close()
               1/50 sec delay        (30,000 connects in 10 mins)
               }

On Embedded EDK unit:
Server:   socket()
             bind()
             listen()

             while (1)
               {
               accept()
               close()
               }


Thanks,

 ShutEye Thinkin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
