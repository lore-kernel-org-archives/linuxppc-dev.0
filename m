Message-Id: <200001151456.PAA00587@piglet.grunz.lu>
Date: Sat, 15 Jan 2000 15:56:32 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Network trouble
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

For some time now, I've beenm experiencing horible network performance.
Often, TCP connections would hang; browsing sites would be horribly
slow, whereas a ping or traceroute shows no problems whatsoever.

I've had one FTP transfer from dev.linuxppc.org, that got me 1 kB/S,
whereas at the same time from my provider's machine, I got 20 kB/s. So
I think the Internet itself is not to blame.

My net connection is via a router and ISDN to my provider; I've had a
look at the router: no bad packets or anything that would indicate
problems.

So I've started looking at my local box, and I've seen the following in
netstat:

[mlan@piglet ~]$ netstat -an
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp       24      0 piglet:1179             devel.linuxppc.org:ftp  ESTABLISHED 

tcp    16060      0 piglet:1256             mcp:ftp-data            ESTABLISHED 
tcp        0      0 piglet:1256             *:*                     LISTEN      
tcp        0      0 piglet:1255             mcp:ftp                 ESTABLISHED 

tcp        0   2896 localhost:3128          localhost:1111          ESTABLISHED 
tcp        0      0 localhost:1111          localhost:3128          ESTABLISHED 

So I've seen large queues build up, even for local connections ??? I'm
running squid as a local proxy; and I've often seen netscape <-> squid
connections that were'nt shut down properly, thus:

[mlan@piglet ~]$ netstat -an
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 127.0.0.1:3128          127.0.0.1:1101          FIN_WAIT2   
tcp        1      0 127.0.0.1:1101          127.0.0.1:3128          CLOSE_WAIT  
tcp        0      0 127.0.0.1:3128          127.0.0.1:1092          FIN_WAIT2   
tcp        1      0 127.0.0.1:1092          127.0.0.1:3128          CLOSE_WAIT  

I'm running kernel 2.2.13 on a PowerMac 7600, with nothing else special
network-wise. My ethernet interface stats don't show anything weird
neither.

Anybody have any clue what's going on? Bug in the PPC networking code?

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
