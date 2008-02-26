Return-Path: <maynardj@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03010DDF03
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 01:49:40 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1QEnaPY006484
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 09:49:36 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1QEnUhg201648
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 07:49:31 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1QEnS1f006081
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 07:49:28 -0700
Message-ID: <47C426F8.7070203@us.ibm.com>
Date: Tue, 26 Feb 2008 08:49:28 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: copy_from_user problem
References: <47C36FBA.1030600@us.ibm.com> <1203994599.15052.84.camel@pasglop>
In-Reply-To: <1203994599.15052.84.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------000504030706060407050108"
Cc: linuxppc-dev@ozlabs.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000504030706060407050108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Mon, 2008-02-25 at 19:47 -0600, Maynard Johnson wrote:
>> Hi,
>> I'm developing a kernel module that needs to parse the in-memory ELF 
>> objects for a shared library (libc, to be specific).  When running my 
>> test on a 32-bit library, it works fine, but for a 64-bit library, the 
>> very first copy_from_user() fails:
>>     Elf64_Ehdr ehdr;
>>     copy_from_user(&ehdr, location_of_lib, sizeof(Elf64_Ehdr);
>>
>> I talked this over a bit with Will Schmidt.  He determined that 
>> access_ok (being done as a result of copy_from_user) was failing, but we 
>> don't know why.  I have 32-bit and 64-bit testcases that start up and 
>> then pause, waiting for input.  We look at the entry for libc in 
>> /proc/<pid>/maps, and the permissions are the same for both 32-bit and 
>> 64-bit.
>>
>> I've run this test on both a stock SLES 10 SP1 kernel and on 2.6.24. 
>> I'm sure this is a user error, but for the life of me, I don't know what 
>> I'm doing wrong.
>>
>> Can anyone out there help?
> 
> I would have to look at the code.
Ben,
I've pared down the code to a minimal testcase and attached the source 
file.  Here are the makefile rules to build it:

----------------------------------------------
obj-m := uaccess_test.o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)
default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
clean:
	rm -f *.mod.c *.ko *.o .*.cmd
	rm -rf .tmp_versions

----------------------------------------------

Instructions:
1. Write a simple C program that will pause, waiting for input, so that 
you can obtain the address of libc to pass into the uaccess_test kernel 
module.  For example:
#include <stdio.h>

int main(void)
{
         printf("Press Enter to continue.\n");
         getchar();

        return 0;
}
--------------
2. Compile C program as 32-bit; then run it.  While the program is 
waiting for input, obtain its PID and do 'cat /proc/<pid>/maps' to get 
the address of where libc is loaded.
3. From the dir where you build the uaccess_test kernel module:
         'insmod ./uaccess_test.ko lib_addr=0x<mem_loc_libc>'
    This should succeed.  dmesg to verify.
4. Unload the module.
5. Recompile your C program with -m64; start it up and obtain the 
address of libc again (now a 64-bit address).
6. Load the uaccess_test kernel module and pass 
'lib_addr=0x<mem_loc_libc>'.  Note that this time, the load fails. 
dmesg to see debug printk's.


Thanks for any light you can shed on this!

-Maynard
> 
> Ben.
> 
> 


--------------000504030706060407050108
Content-Type: text/plain;
 name="uaccess_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uaccess_test.c"

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <asm/uaccess.h>

static long lib_addr;
module_param(lib_addr, long, 0);
MODULE_PARM_DESC(lib_addr, "lib_addr");



static unsigned long parse_elf64(unsigned long start_loc)
{
	Elf64_Ehdr * ehdr;
	int ret = 0;

	ehdr = kmalloc(sizeof(Elf64_Ehdr), GFP_KERNEL);
	if (copy_from_user((void *)ehdr, (void *) start_loc, sizeof(Elf64_Ehdr))) {
		printk("cannot get Elf64_Ehdr from "
		       "start_loc %lx\n", start_loc);
			goto out;
	}
	if (ehdr->e_ident[EI_CLASS] != ELFCLASS64) {
		printk("EI_CLASS of Elf64_Hdr is incorrect! %d\n",
		       ehdr->e_ident[EI_CLASS]);
		goto out;
	}
	if (ehdr->e_type != ET_DYN) {
		printk(KERN_INFO "LPA: "
		       "%s, line %d: Unexpected e_type %u parsing ELF\n",
		       __FUNCTION__, __LINE__, ehdr->e_type);
		goto out;
	}
	ret = ehdr->e_ident[EI_CLASS];
	printk(KERN_INFO "Elf class from Ehdr is %d\n", ret);
 out:
	return ret;
}

static unsigned long parse_elf32(unsigned long start_loc)
{
	Elf32_Ehdr ehdr;
	int ret = 0;

	if (copy_from_user(&ehdr, (void *) start_loc, sizeof (ehdr)))
		goto out;
	if (ehdr.e_ident[EI_CLASS] != ELFCLASS32)
		goto out;
	if (ehdr.e_type != ET_DYN) {
		printk(KERN_INFO
		       "%s, line %d: Unexpected e_type %u parsing ELF\n",
		       __FUNCTION__, __LINE__, ehdr.e_type);
		goto out;
	}
	ret = ehdr.e_ident[EI_CLASS];
	printk(KERN_INFO "Elf class from Ehdr is %d\n", ret);
 out:
	return ret;

}

int find_ehdr(unsigned long start_loc)
{
	int ret = 0;
	if (!(ret = parse_elf32(start_loc)))
		ret = parse_elf64(start_loc);
	return ret;
}



int __init init_module(void)
{
	if (!(find_ehdr(lib_addr))) {
		printk(KERN_INFO "uaccess test failed\n");
		return -1;
	}
	    printk(KERN_INFO "uaccess test succeeded\n");
        return 0;
}

void __exit cleanup_module(void)
{
}
MODULE_LICENSE("GPL");


--------------000504030706060407050108--
