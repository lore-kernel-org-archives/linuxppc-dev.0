Date: Fri, 22 Nov 2002 11:14:17 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: linuxppc_2_4_devel, rc1 and rc2 problem.
In-reply-to: <23761.1037957518@passion.cambridge.redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEDNFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> -ENOCONTEXT.
:-), sorry the context was lost due to me beeing a moron.

Anyway here is the problem again:

I upgraded my linuxppc_2_4_devel from pre8(1.1130) to rc1(1.1157) and noticed that
my syslog had problems to start:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 64k init
INIT: version 2.78 booting
Fast boot, no file system check
none on /dev/shm type shm (rw)
ramfs on /tmp type ramfs (rw)
ramfs on /var/run type ramfs (rw)
ramfs on /tftpboot/log type ramfs (rw)
Cleaning: /etc/network/ifstate.
Enabling packet forwarding: done.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: done.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd/etc/rc.d/rc2.d/S10syslog: line 53:    50 Ter
minated              start-stop-daemon -v --start --quiet --exec /sbin/syslogd -
- $SYSLOGD
 klogd.
Starting internet superserver: inetd.

I then started to backout the changes between pre8 and rc1 to see where the problem was.
That gave me:

>> Aaargh, now I am getting it in pre8 as well. However I have made
>> some progress:
>>
>> I have 2 custom boards one mpc862(100Mhz, 16KB icache, 8KB dcache) and a
>> mpc860(80Mz,4KB icache, 4KB dcache). If I overclock the mpc860 to 100MHz I get
>> the same problem. If I set the clock on both boards to 95MHz all is well. If I overclock
>> the mpc862 to 105 MHz it works fine.
>>
>> It turns out that syslog is actually running after the error. If I stop syslog and
>> start it again it works fine. If adjust my script so klogd is started before
>> syslogd all is well to.
>>
>> This looks like a race somewhere to me, but i have no clue as to where.
>>
>> Anyone?
>>
>>     Jocke
>
>hmm, if I upgrade the JFFS2 filesystem to CVS HEAD, the problem goes away.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
