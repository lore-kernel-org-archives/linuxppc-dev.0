To: shuaiye1999@sohu.com
Cc: "hi" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem when using linuxppc-2.4.4 in mpc8260 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Jul 2003 17:16:45 +0800."
             <1222072.1058347005274.JavaMail.postfix@mx49.mail.sohu.com>
Date: Wed, 16 Jul 2003 17:10:03 +0200
Message-Id: <20030716151008.27C22C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Shuaiye,

in message <1222072.1058347005274.JavaMail.postfix@mx49.mail.sohu.com> you wrote:
>
>      I have a bad headache of the memory problem of mpc8260 board using
> linuxppc-2.4.4, the ELDK version.we got 32M ram,after booting,it seems
> have 21000 K free,but when we use the system,it seems have little
> memory.I did a simple test about this,and use bdi2000+gdb get some

I assume you are uysing a ramdisk, right? How big  is  this  ramdisk?
Otherwise 21000 K free is not reasonable.


What makes you think you are running out of memory?

> data.and feel lost about the infomation.Can anybody give some infomation
> about it? thx a lot.

Which sort of data are you _trying_ to get in  the  first  place?  It
makes  little  sense  just  to  poke  around when you don;t know what
you're looking for...

> ==>the simple program is used to test:
>
> sleep1.c:
>
> main()
> {
>         while(1)
>                 sleep(1);
> }
>
> ==>call it 12 times:
>
> bash-2.05#./sleep1 &
> [12] 229
>
> ==>just now ,it jump into the break point:
>
> Breakpoint 4, bad_page_fault (regs=0xc1cd3ab0, address=2104558664, sig=2104558456) at fault.c:224
> 224             if ((fixup = search_exception_table(regs->nip)) != 0) {
>
> (gdb) bt
> #0  bad_page_fault (regs=0xc1cd3ab0, address=2104558664, sig=2104558456) at fault.c:224
> #1  0xc000c964 in do_page_fault (regs=0xc1cd3ab0, address=2104558664, error_code=536870912) at fault.c:185
> #2  0xc0003de4 in ret_from_except () at init/main.c:858
> #3  0xc00fbec4 in udp_data_ready (sk=0xc0254680, len=2104558664) at xprt.c:654
> #4  0xc00e9624 in udp_queue_rcv_skb (sk=0xc0254680, skb=0xc025d620)
...


I see no problem here. Linux implements  virtual  memory,  so  it  is
perfectly normal that page faults happen (and will be handled).


What exactly is your problem?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A committee is a life form with six or more legs and no brain.
                              -- Lazarus Long, "Time Enough For Love"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
