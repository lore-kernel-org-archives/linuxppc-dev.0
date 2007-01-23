Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id AACAFDDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 17:01:16 +1100 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id BD63F8780D7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 22:01:03 -0800 (PST)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 7EA568780CC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 22:01:03 -0800 (PST)
Message-ID: <45B5A499.4060401@gmail.com>
Date: Tue, 23 Jan 2007 11:30:57 +0530
From: sudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: Vijay Sampath <vsampath@gmail.com>
Subject: Re: regarding kgdb in ppc
References: <12c9fc1a0611280820h748cd520pd5546e2803dbab82@mail.gmail.com>	
	<d16b1c80611301101n5f9ea44died47d2ff1bac4221@mail.gmail.com>	
	<12c9fc1a0611302029h36f29943s119f8ad70b95f2c4@mail.gmail.com>	
	<12c9fc1a0612010331p2c33c048j1af6006deda14abb@mail.gmail.com>	
	<d16b1c80612010540k7600f0e1n92fadd3d539d75bf@mail.gmail.com>	
	<12c9fc1a0612040805p64f23a7bj42fd27891294dfc2@mail.gmail.com>	
	<458E384A.108@gmail.com>	
	<198592450612281634l3e71834i5915139a73e8f5d1@mail.gmail.com>	
	<758a2bbf0612281702u3a4f383bi14e418410bd4f912@mail.gmail.com>	
	<45964D27.6020708@gmail.com>
	<758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>
In-Reply-To: <758a2bbf0612301753q27727b01w92681214a6296434@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kernelnewbies@nl.linux.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vijay Sampath wrote:
> Sorry no idea. The configuration and options for kgdb are different in
> my architecture. In make menuconfig, under "Kernel Hacking', I enable
> kgdb and choose its serial port (ttyS0 or ttyS1). After this if I just
> pass a string with "kgdb" in it in the commandline, it halts early on.
> Looks like kgdb function is different in your architecture. You will
> have to read the code that implements your kgdb setup. Clearly it is
> not happy with the arguments you are passing it, as evident in the
> output.
>
> BTW I am using Linux kernel version 2.6.16 on a IBM405EP board. kgdb
> breakpoint is setup in setup_arch() in arch/ppc/kernel/setup.c. Note I
> also enabled CONFIG_WANT_EARLY_SERIAL in the processor configuration.
> Not sure if this is important.
>
In my setup i have one serial port on the target(MPC8540) and one on 
host(x86). The document(kgdb_docu_full-2.4.pdf) by default considers 
having two serial ports(two on target and two on host).

Can anyone plz guide me how to proceed when i have only one serial port . ?

I want to know the initilization steps for estrablishing the serial 
communication between kgdb(in target) and gdb on host. I tried one or 
two ways but couldnot succeed.

Thanks
Sudheer
> Vijay
>
> On 12/30/06, sudheer <urwithsudheer@gmail.com> wrote:
>> Vijay, Thanks  for the reply.
>> But before trying these options i want to clear one more issue.
>> While booting the kgdb kernel the kernel claims "kgdb initialisation
>> failure." I have observed it very lately.
>>
>> Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
>> Linux version 2.6.15.5 (root@Sudheer) (gcc version 3.4.4) #2 Fri Dec 
>> 29 17:58:40 IST
>> 2006
>> KGDB cannot initialize I/O yet.
>> Invalid syntax for option kgdb8250=
>> Malformed early option 'kgdb8250'
>> Built 1 zonelists
>> Kernel command line: console=ttyS0,115200 root=/dev/ram rw kgdbwait 
>> kgdb8250=0,115200
>> OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
>> PID hash table entries: 2048 (order: 11, 32768 bytes)
>> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>>
>>
>>
>>
>> I have changed the kgdb8250 arg to 1,0, but the result is same.
>> And ......
>> I have checked the serial cable NULL Mode connecting  x86 systems
>> serially- with Cat and echo and this is fine.
>> When i try with Unpatched kernel on target and host(x86) - cat <
>> /dev/ttyS0 doesnt wait  and returns to prompt.
>> I tried with 2.6.13 and 2.6.15.5 with resepective kgdb patches, but the
>> result is same (kgdb Initialization failure). I am not sure where  am
>> doing the mistake.
>> Please guide me in right way and also please let me know if any  more
>> details are required.
>> Happy New Year in Advance.
>>
>> Thanks
>> Sudheer
>>
>>
>>
>>


>>
>>
>
