Message-Id: <199909221912.VAA06565@piglet.cpu.lu>
Date: Wed, 22 Sep 1999 21:12:21 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Stupid question of the day: Ethernet IP aliases on startup
To: jgrantha@hannover.sgh-net.de
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199909212103.VAA03918@go.hannover.sgh-net.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  21 Sep, this message from John L Grantham echoed through cyberspace:
> 
> Hi all,
> 
> My stupid question of the day, on a similar vein to some other questions 
> recently: I'm trying to set up my Linux box (PowerMac G3 MT/266, LinuxPPC 
> 1999 crossed with YDL 1.1) to start up Ethernet IP aliases each time the 
> computer boots. First attempt was using netcfg, which set up the aliases 
> okay, and in each case the files for eth0:0 through eth0:7 in 
> /etc/sysconfig/ says ONBOOT=YES, but the aliases don't start on boot. So 
> I wrote a shell script to do so, and the script works if I call it 
> (though it complains that the files already exist, but it does start the 
> ports); the script I wrote is in /etc/sysconfig/network-scripts/, with a 
> symbolic link pointing to it from /etc/rc.d/init.d/. But no dice--on 
> startup, nothing doing, and I have to call the script myself.

What you need is a symbolic link from one (or more) of the directories
/etc/rc.d/rcx.d, called Syy.netscripts, pointing to your script.

The key is that only scripts in those directories are executed, if and
only if the runlevel no. x is entered. Scripts named Syy.something are
 called with the argument 'start', those named Kyy.something are called
with 'stop'. In any case, yy is a number that defines the order in which
the scripts are executed.

The standard runlevels are 3 (regular console) or 5 (with X, usually
through xdm).

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
