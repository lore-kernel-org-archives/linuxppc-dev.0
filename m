Message-Id: <200010121640.MAA06292@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Thu, 12 Oct 2000 17:49:22 +0200." <Pine.HPX.4.10.10010121719150.16113-100000@gra-ux1.iram.es>
Date: Thu, 12 Oct 2000 12:40:17 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

>> On the kernel side, one of the PCI IO busses will be mapped to ISA. What
>> I'll do is basically to change the kernel inb/outb functions to do
>> something like
>>
>> if (addr < 64k)
>> do_io(isa_io_base + addr)
>> else
>> do_io(addr)

Gabriel> No please, is there anybody bloat-conscious on this damned list ? Burying
Gabriel> more and more code inside each {in,out}[bwl] is not the solution.

Gabriel> Just define a macro ISA_PORT or something like this and update the kernel
Gabriel> to replace all the in/out to fixed ports to do in/out(ISA_PORT(n)). If you
Gabriel> don't do it you'll get a nice panic so you'll find all the places quite
Gabriel> fast.

	Yes, it is very important to avoid adding many layers of branches
to the code if anyone cares about performance.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
