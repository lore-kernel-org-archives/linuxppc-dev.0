Message-Id: <v04003a00b629d6998c64@[24.70.162.12]>
In-Reply-To: <20001104073540.A23753@xim.dyndns.org>
References: <v04003a01b629191ff4ae@[24.70.162.12]>; from
 nicoya@apia.dhs.org on Fri, Nov 03, 2000 at 08:01:55PM -0600
 <v04003a00b628feabbda6@[24.70.162.12]>
 <v04003a00b628feabbda6@[24.70.162.12]>
 <p04330100b629125ff911@[192.168.0.1]>
 <v04003a01b629191ff4ae@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 4 Nov 2000 09:32:23 -0600
To: spiette@generation.net, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: whacked out 2.2.18pre17?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:35 AM -0600 11/4/2000, Simon Piette wrote:
[...]
>Could you elaborate on that? I have an IMSTT 128 (2Mb VRAM) and I'm
>unable to accelerated video on a plain pmac kernel. I am currently stuck
>at kernel 2.2.12 because this is the only kernel that will accept a
>patch from Ryen Nielsen (http://krazynet.com/~ran/linux/imsttfb.c).
>The last pmac I tried is 2.2.16

I'm not sure how much I can elaborate on it, since I've never actually
managed to get it to not work.


[...]
>$ cat /proc/cmdline
>root=/dev/sdb6 video=imsttfb:vmode:17,cmode:16 idebus=66 hda=noautotune

merida:~# cat /proc/cmdline
root=/dev/hde1 adb_buttons=113,107


>$ lspci -vv
>[snip]
>00:0e.0 Display controller: Integrated Micro Solutions Inc. IMS9129 (rev 01)
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>ParErr- Stepping- SERR- FastB2B-
>        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
><TAbort- <MAbort- >SERR- <PERR-
>        Latency: 8 min, 8 max, 32 set
>        Interrupt: pin A routed to IRQ 24
>        Region 0: Memory at 82000000
>        (32-bit, prefetchable)

merida:~# lspci -vv
[...]
01:0f.0 Display controller: Integrated Micro Solutions Inc. IMS9129 [Twin
turbo 128] (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cat- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at 92000000 (32-bit, prefetchable)
	Expansion ROM at 90000000 [disabled]
[...]

looking through /var/log/kern.log, we have...
[...]
MacOS display is /bandit/IMS,tt128mbA
Console: switching to colour frame buffer device 160x64
fb0: IMS TT (IBM) frame buffer; 4MB vram; chip version 2
[...]

And that's about it. I'm booting with BootX, by the way.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
