To: toa@pop.agri.ch
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook, hda power off sequence (for IBM travelstar)
References: <Pine.SOL.4.10.10101061727190.28634-100000@frogger.gpcc.itd.umich.edu> <19341203045809.13248@mailhost.mipsys.com> <3A59CF72.750A6C1A@pop.agri.ch>
From: Henner Eisen <eis@baty.hanse.de>
Date: 11 Jan 2001 01:37:52 +0100
In-Reply-To: Andreas Tobler's message of "Mon, 08 Jan 2001 15:32:29 +0100"
Message-ID: <ou1yuaappb.fsf@baty.hanse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Andreas" == Andreas Tobler <toa@pop.agri.ch> writes:

    Andreas> I'm also interested in this fix since I got my travelstar
    Andreas> DJSA-220 finally to work on a WALLSTREET! I remarked the
    Andreas> same noisy click and since the troubles I had with a dead
    Andreas> toshiba I pay very much attention to strange noises.

I just replaced the original 3GB hard disk (Fujitsu MHH 2032AT) of my
revision 1 iBook by a 20 MB (Toshiba MK2016GAP) drive. This works without
problems, except that halting the machine now also causes a rather noisy hard
drive click.

A quick fix to remove this for init-controlled shutdown is
to just append a `hdparm -Y' to the /etc/rc.d/halt script such
that the drive will put into sleep mode before power is switched off.

The only problem is that `hdparm' cannot be the very last command because
the last command needs to be `reboot' or `halt'. One needs to make sure
that `reboot' or `halt' is already in the buffer cache before it is
executed -- otherwise, the system will restart the hard drive in
order to read the `halt' or `reboot' executable from disk. In order to
get them (and the portions of the shell that will execute it) into the
buffer cache, some dummy access to these objects need to be made before
hdparm is called. The follwing modification to the tail of SuSE 6.4
/etc/rc.c/halt scripts causes the HD noise on power down to disappear.
I guess it should work similarly for all sysvinit based systems.


 mount -no remount,ro / 2> /dev/null
 sync

 echo $message
+cat /sbin/$command > /dev/null
+( exec /bin/echo > /dev/null )
+hdparm -Y /dev/hda
 exec $command -d -f


Henner

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
