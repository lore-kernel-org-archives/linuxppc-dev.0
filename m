Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: shuaiye1999@sohu.com
Message-ID: <1222072.1058347005274.JavaMail.postfix@mx49.mail.sohu.com>
Date: Wed, 16 Jul 2003 17:16:45 +0800 (CST)
To: "hi" <linuxppc-embedded@lists.linuxppc.org>
Subject: memory problem when using linuxppc-2.4.4 in mpc8260 board
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all:

     I have a bad headache of the memory problem of mpc8260 board using
linuxppc-2.4.4, the ELDK version.we got 32M ram,after booting,it seems
have 21000 K free,but when we use the system,it seems have little
memory.I did a simple test about this,and use bdi2000+gdb get some
data.and feel lost about the infomation.Can anybody give some infomation
about it? thx a lot.

==>the simple program is used to test:

sleep1.c:

main()
{
        while(1)
                sleep(1);
}

==>call it 12 times:

bash-2.05#./sleep1 &
[12] 229

==>just now ,it jump into the break point:

Breakpoint 4, bad_page_fault (regs=0xc1cd3ab0, address=2104558664, sig=2104558456) at fault.c:224
224             if ((fixup = search_exception_table(regs->nip)) != 0) {

(gdb) bt
#0  bad_page_fault (regs=0xc1cd3ab0, address=2104558664, sig=2104558456) at fault.c:224
#1  0xc000c964 in do_page_fault (regs=0xc1cd3ab0, address=2104558664, error_code=536870912) at fault.c:185
#2  0xc0003de4 in ret_from_except () at init/main.c:858
#3  0xc00fbec4 in udp_data_ready (sk=0xc0254680, len=2104558664) at xprt.c:654
#4  0xc00e9624 in udp_queue_rcv_skb (sk=0xc0254680, skb=0xc025d620)
    at /home/xdhe/begin/linux-2.4/include/net/sock.h:1191
#5  0xc00e9aa8 in udp_rcv (skb=0xc025d620) at udp.c:908
#6  0xc00ca1c0 in ip_local_deliver (skb=0xc025d620) at ip_input.c:265
#7  0xc00ca618 in ip_rcv (skb=0xc025d620, dev=0x7d710448, pt=0xb) at ip_input.c:372
#8  0xc00c037c in net_rx_action (h=0xc1cd3ab0) at dev.c:1485
#9  0xc0016880 in do_softirq () at softirq.c:78
#10 0xc0003e0c in do_bottom_half_ret () at init/main.c:858
#11 0xc002180c in do_wp_page (mm=0xc0004de8, vma=0xc19a5f20, address=269104860, page_table=0xc1b7a28c, pte=
      {pte = 25297283}) at memory.c:953
#12 0xc002226c in handle_mm_fault (mm=0xc02e8220, vma=0xc19a5f20, address=269104860, write_access=33554432)
    at memory.c:1312
#13 0xc000c860 in do_page_fault (regs=0xc1cd3e90, address=269104860, error_code=167772160) at fault.c:149
#14 0xc0003de4 in ret_from_except () at init/main.c:858
#15 0x10019804 in ?? ()

best regards.

shuaiye

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
