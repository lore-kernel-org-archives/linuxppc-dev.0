Message-ID: <3891367F.1F7C44C9@ict.ac.cn>
Date: Fri, 28 Jan 2000 14:26:07 +0800
From: LiuTao <tliu@ict.ac.cn>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13: Now booting the kernel
References: <38910239.BFB31D0E@ctam.com.au>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Brendan:

mpc8xx-2.2.13 still doesn't run on my board. I use emulator(EST tool)
to debug the system through JTAG port. I download the zImage to the
board, then run it. Something displayed on serial port:
loaded at:     00800000 0080B1C8
board data at: 00800158 00800180
relocated to:  007F0100 007F0128
zimage at:     00830263 0088A2B1
avail ram:     0088B000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

Now, the program has unziped the image section(vmlinux) to 0x0,
then jump to 0x0 to enter the linux kernel. Then the program
call identify_machine() in head.S. Here, the problem happened.
Because the content in location of identify_machine() is not
correct. I don't know the reason. Maybe unzip has problem?
I sent help main to the maillist, but nobody give me any
suggestions.
My board is customed too. What kind of debug tool are you using
to debug linux on your board?


LiuTao


Brendan J Simon wrote:
>
> Hi Liu.
> I have had embedded-2.2.5 linux running on my custom mpc860 board and
> have now upgraded to mpc8xx-2.2.13.  I am having problems similar to the
> problems you had.
> I am getting "Now booting the kernel" and then nothing else.
> You said below that you understood and resolved the problem.
> What was the problem and how did you resolve it ?
>
> I thought this was a cache problem but I have disabled the caches in
> arch/ppc/kernel/head.S and arch/ppc/mbxboot/head.S but the problem is
> still there.
>
> Can you help.
> Thanks very much,
> Brendan Simon.
>
> -------- ORIGINAL MESSAGE --------
>
> Hi all:
>
> I understood the problem and resolved it.
>
> LiuTao
>
> LiuTao wrote:
> >
> > Hi all:
> >
> > I am porting Linux to a board which has MPC860MH50, 16M RAM and 2M
> > Flash.
> > I am using visionPROBE(emulator of EST) to debug my program.
> > I download the zImage to the board by emulator, then run it.
> > I can see the following:
> >
> > loaded at:     00800000 0080B1C8
> > board data at: 00800158 00800180
> > relocated to:  007F0100 007F0128
> > zimage at:     00830263 0088A2B1
> > avail ram:     0088B000 01000000
> >
> > Linux/PPC load:
> > Uncompressing Linux...done.
> > Now booting the kernel
> >
> > Now, I find that the program stoped at 0x111C.
> >
> > So I set a breakpoint at "blr" in head.S at which the program will
> jump
> > to the kernel. I ran the program again, it stoped at the breakpoint.
> > Then I ran it step by step, I found that it jumped to 0x0000000C, I
> > think
> > that's the correct address. Then, I ran it continuously, it stopped at
>
> > 0x111C again.
> >
> > That's very strange. If I don't set breakpoint at "blr" but set a
> > breakpoint
> > at 0x000C, the program can't stop at the breakpoint but stop at
> 0x111C.
> > If I
> > set breakpoint at "blr" and run it step by step, the program can get
> > 0x000C.
> >
> > Do you have any suggestions?
> > Thanks!
> >
> > LiuTao

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
