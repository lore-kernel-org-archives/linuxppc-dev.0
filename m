Message-ID: <39671310.96C22BBD@noos.fr>
Date: Sat, 08 Jul 2000 13:40:00 +0200
From: Guillaume Laurès <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
CC: mlan@cpu.lu
Subject: Re: Trying to enable backside on a G4
References: <200007080615.IAA00725@piglet.grunz.lu>
Content-Type: text/plain; charset=iso-8859-1; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners a écrit :

>
> If you're working on 2.4.0-style kernels, here is a patch that
> implements this functionality as a kernel command line option.

Hum, did you forget to join the patch ???

And what about the l2cr=xxxxxxxx option in the next kernels, will it be re-enabled or should we
keep on user-space ?

>
>
> If you are trying to produce a standalone program, your example code
> will not work. It will only work inside the kernel, not from userspace.
> You could try to build it as a module....

OK, let's schedule this for later...

>
>
> But then again, you can easily set the l2cr from userspace. I have this
> in my /etc/rc.d/rc.sysinit:

I followed your setup and put :

        echo -n "Enabling level2 cache..."
        echo 0 > /proc/sys/kernel/l2cr
        echo '0x35300000' > /proc/sys/kernel/l2cr
#disabled,no parity,1MB,+1.5 clock,pipelined burst SRAM,data only,global invalidate,ZZ
enabled,copy-back,0.5ns hold
        echo '0xb5100000' > /proc/sys/kernel/l2cr
#enabled,no parity,1MB,+1.5 clock,pipelined burst SRAM,data only,ZZ enabled,copy-back,0.5ns hold

        echo

Since :
 - GrabG3CacheSetting (slightly modified to accept any processor or it would complain that I
don't have a G3...) from BenH told me that XLR8's extension sets my G4's L2CR to 0xb5100000
 - I don't really understand what the the L2I bit stands for, is it necessary to set it on the
second echo too as you do ?

>
> Be aware that there might be problems with just using the echo>
> technique, as the cache needs to be invalidated before enabling it.
> Normally that should happen automagically; however it didn't work for
> me. That's why there are two 'echo's above.

So may be it's viser to do as a general rule :

echo 0 > /proc/sys/kernel/l2cr # (disable)
echo '0x00200000' > /proc/sys/kernel/l2cr # (invalidate)
echo '0x_what_your_card_supports' /proc/sys/kernel/l2cr # (set up and enable)

>
>
> My final l2cr value is:
>
> [mlan@piglet ~]$ cat /proc/sys/kernel/l2cr
> 0xa9000000:  enabled, no parity, 512KB, +2 clock, pipelined burst SRAM, copy-back, 0.5ns hold

gom@pm8600:~$ cat /proc/sys/kernel/l2cr
b5100000:  enabled,no parity,1MB,+1.5 clock,pipelined burst SRAM,data only,ZZ
enabled,copy-back,0.5ns hold
And kernel compilation is now at least twice as fast...

>
>
> Have fun

Oh, I did ;-)

--
Guillaume


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
