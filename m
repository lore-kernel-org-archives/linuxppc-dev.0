Mime-Version: 1.0
Message-Id: <v04210101b4132312764f@[206.173.234.57]>
Date: Sat, 25 Sep 1999 18:49:14 -0700
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: Randall R Schulz <rrschulz@cris.com>
Subject: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

In my lonely quest to solve the problem I'm having with the stalling 
of inbound (only, it seems) TCP streams over PPP (but not local 
loopback, it seems), I'm reaching the grasping at straws stage.

By using tcpdump, I have discovered what seems to be a relevant fact: 
When the stream stalls, the sending side (always the remote) is 
resending the same range of bytes (sequence numbers) over and over 
again with an inter-packet arrival time that increases gradually 
until it reaches about two minutes where it holds until one side or 
the other gives up and closes the stream. Each such packet has the 
PUSH flag set and elicits an ACK from my system, but for whatever 
reason, the remote just keeps sending repetitions of a packet 
containing the same range of sequence numbers (with a total of 1448 
data bytes each).

I have captured the tcpdump output from one of these "sessions" 
(beginning when I clicked a FTP URL link in Navigator through until I 
cancelled the stalled transfer after several repetitions at the 
two-minute inter-packet arrival time. There are 140 lines of tcpdump 
output. If anybody can make use of this in diagnosing the problem, 
I'd be happy to send it...

This problem is easily repeated, so if there's a better experiment to 
run, I'd likewise be happy to give that a try. If there are specific 
software version numbers to check for known bugs, please inform me. 
I'm comfortable with just about any kind of software reconfiguration, 
but have never built a Linux kernel.


In looking over various messages to LinuxPPC-Dev and -User, I've 
noticed that there's a variety of MTU values in use for PPP links. 
Values I've seen are:  296, 542, 1500, 1514. Every time I've run 
ifconfig while I have a PPP link active, I've seen 1500 on my system.

I'm wondering what is the significance of the particular value used, 
especially given the wide range of values that appear to be used. Of 
course, mostly I'm wondering if there might be some subtle effect 
(read "bug") related to the 1500 value in effect on my system and my 
problem with stalling TCP streams.

I have always used kppp to establish my PPP connections and it has 
always worked very well. I am curious if there's some issue there 
that I'm not aware of. I used to run MkLinux on an 8500 where I put 
together PPP configuration by hand and never had these problems. By 
scouring the LinuxPPP- mailing list archives and 
comp.os.linux.networking I see that I'm not entirely alone in 
experiencing symptoms that seem similar to mine, but obviously it's 
not a common problem.

I'd like to try changing my PPP MTU from 1500 to 1514, but I don't 
know where to control it under kppp and the documentation doesn't 
mention it.


Lastly, a little configuration information: LinuxPPC recently 
installed from scratch using LinuxPPC Q3 CD-ROM (all packages except 
non-Macintosh kernels installed using the X-based installer). Apple 
Macintosh B&W G3 rev. 1. Built-in Apple-supplied modem. Modem init 
string copied from MacOS OT/PPP Remote Access modem script for this 
modem. All (active) hard drives are on the Apple-supplied Adaptec 
2940U2B Ultra 2 LVD SCSI bus. 384 Mbyte memory and 25 Gbyte disk (not 
all ext2 volumes). Initio 9100UW (Ignored). DVD-ROM and Zip drives on 
IDE/ATA bus.


Any and all help will be greatly appreciated!

Randy Schulz
Mountain View, CA USA

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
