Message-ID: <396F0E19.9DBCAE70@wtal.de>
Date: Fri, 14 Jul 2000 14:56:57 +0200
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: iBook issues
References: <396D7F71.BD3894F0@wtal.de> <20000713110104.24482@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I forgot to CC'd to linuxppc-dev. Here it is for the records.

summary:
gmac is ok
power management is a noop
atyfb/X11 solved

Benjamin Herrenschmidt wrote:

> >Hi Ben,
> >
> >gmac now works well again on my iBook!
> >
> >There are still three issues remaining:
> >- the iBook doesn't power off on system halt (the ancient SuSE kernel did)
>
> Which kernel ? The one on the web page ?

Yes, the one on your web page (vmlinux-2.2.17pre9-ben1). SuSE's
2.2.13-patched
turned it off.

> >(- repeatedly pressing brightness controls do no longer erase the nvram and
> >power off, solved )
>
> My kernel should actually handle brightness (increase and decrease it)
> provided that you enable atyfb in the kernel.

It doesn't work for me (pressing these keys are a no-op, which is
actually better
than powering off).
I used your kernel with 'append="adb_buttons=52,76"'. Atyfb was active
at that
time.

> >- 2.4test1-ac21 now tells me "IDE-DMA check !" and fails to mount root
> >(perhaps
> >a missing idebus=?)
>
> Where are some issues with 2.4, I'm working on them.

If I understand this sentence right you know about it and are working on
it.

> >Using it for data exchange is a good idea. But I heard about MacOS unblessing
> >the boot folder. I thought this was my problem.
>
> Well, I personally never bless it :) I directly configure OF to load a
> boot script on this partition that will, depending on me pressing the
> space bar or not, boot either MacOS or yaboot (using hard-coded path, so
> I don't depend on blessing).

Good idea. Should make it's way into the yaboot-FAQ since you don't need
to
repartition.


> >Somewhat working. It is blastingly fast compared to ofonly, but my X server
> >(SuSE beta) isn't able to use it correctly. A strange thing (screen turns
> >white,
> >some black dots appear (like noise) and stay, if you press a key the screen
> >looks garbled (wrong colors, dots not in a row) but it doesn't look like
> >a sync
> >problem and I specify Mode "default" of course. I will further dive into it
> >(downloaded fbset & fbutil) and even try 4.0.1 (which I plan anyway).

I found it. It looks like the two accelerations step on each others
feet. If you
disable acceleration on your text consoles, X works right. This might
already
have been fixed (SuSE's beta X Server is of Aug'99).
And the fact that the virtual resolution is 800 5222 might make it
impossible to
find your login window (which is centered) 8-o

Apart from that I didn't succeed to access the mouse. I know usb-hid
maps it
somewhere, but where?


> >What I think is even more important: lack of HFS[+] is a showstopper on
> PPC! I
> >have no free ressources to help but it'll kill Linux's reputation in the Mac
> >world if not solved within a few months.
>
> Some people are working on it. I don't know the status.

Good to hear, seeing 'my Mac partition has been destroyed' by casual
Linux users on this list gives me shivers. This often hides a personal
tragedy.

Christof

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
