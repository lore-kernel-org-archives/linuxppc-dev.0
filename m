To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel Module; globals badly initialized, help needed.
References: <6B546A602AD2D211BFF00008C7A428890584401D@hrtades2.atea.be>
From: Bruno Vetel <bruno.vetel@wanadoo.fr>
Date: 19 Mar 2002 01:22:44 +0100
In-Reply-To: <6B546A602AD2D211BFF00008C7A428890584401D@hrtades2.atea.be>
Message-ID: <84r8mhe78r.fsf@pommard-eth0.art2.com4.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

We had a problem similar to yours with an HHL 1.0. An update of insmod et rmmod from busybox
solved our problem

        Bruno

Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be> writes:

> (This messages was already posted on the linuxppc-dev list, put posting it
> to this list failed...)
>
> Hi,
>
> I am having lots of problems with global variables that are badly
> initialized in a kernel
> module. I wrote some very simple code showing the problem. The compiler
> I use is gcc 2.95.3
> (the one that comes with HHL2.0).
>
> Is this a compiler problem -do I need to use some special options?- or
> could it
> be a problem with insmod, the kernel, ...?
>
> I had this problem before with DECLARE_WAIT_QUEUE_HEAD where the
> pointers inside the structure where badly initialized. The only
> sollution was to reinitialize the fields at runtime. I posted this issue
> and somebody reported he had seen the same issue.
>
> Who can help we with this?
>
> Thanks!
> Frederic
>
>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
>
>
> #if defined(CONFIG_SMP)
> #define __SMP__
> #endif
>
> #if defined(CONFIG_MODVERSIONS)
> #define MODVERSIONS
> #include <linux/modversions.h>
> #endif
>
> char MyMemSpace[2*0x100];
> char *MemPointers[2] = {&(MyMemSpace[0]), &(MyMemSpace[0x100])};
>
> typedef struct
> {
> 	char *szName;
> 	char *szName2;
> } MyStruct_t;
>
> MyStruct_t MyStruct[] = {{"A", "A2"}, {"B", "B2"}};
>
> int init_module(void)
> {
> 	printk("TestDriver 3 Loaded\n");
>
> 	printk("MyMemSpace: 0x%lx 0x%lx \n",  (long)&(MyMemSpace[0]),
> (long)&(MyMemSpace[0x100]));
> 	printk("MemPointers: 0x%lx 0x%lx \n", (long)(MemPointers[0]),
> (long)(MemPointers[1]));
>
> 	printk("First Char is MyStruct[0].szName %c\n",
> MyStruct[0].szName[0]);
>
>
> 	return -1;
> }
>
> void cleanup_module(void)
> {
> 	return;
> }
>
>
>
>
> This is what I get:
>
> MyMemSpace: 0xc304a1ec 0xc304a2ec
> MemPointers: 0xc304a1ec 0xc304a3ec
> First Char is MyStruct[0].szName e
>
>
>
>

--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
