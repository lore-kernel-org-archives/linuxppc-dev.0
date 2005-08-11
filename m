Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 8CD2167EED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 01:25:24 +1000 (EST)
Message-ID: <42FB6DE0.4070506@ru.mvista.com>
Date: Thu, 11 Aug 2005 19:25:20 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <42FA3636.7010804@ru.mvista.com> <42FA3D7B.8040200@ru.mvista.com>
	<42FA4108.9090808@ru.mvista.com>
	<4BA092C9-1517-416E-9C98-90F9D8F41857@freescale.com>
	<20050811053032.GF5665@dmt.cnet>
In-Reply-To: <20050811053032.GF5665@dmt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
 final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> On Wed, Aug 10, 2005 at 02:16:57PM -0500, Kumar Gala wrote:
> 
>>+static int __init find_chip_by_name_and_id(char *name, u32 id)
>>+{
>>+    int ret = -1;
>>+    unsigned int i = 0;
>>+    unsigned int j = 0;
>>+    unsigned int dups = 0;
>>+
>>+    unsigned int matched[count_sys_specs()];
>>
>>Is is legit in the kernel to use dynamically sized array?
> 
> 
> kmalloc() is certainly safer - why not use it? 
Practically , version with kmalloc works, but  setup_arch and thus this 
function is called before mem_init, so I just wonder if kmalloc can 
handle this case. On the other hand, I don't like to deal with
alloc_bootmem() if mem_init_done!=1 and kmalloc otherwise (like ocp 
does) just for the temporary buffer.

But it's the only _right_ way (or I 've missed something) - sure I'll 
follow it.

-- 
Sincerely,
Vitaly
