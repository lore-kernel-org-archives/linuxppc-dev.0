Return-Path: <robertlazarski@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.226])
	by ozlabs.org (Postfix) with ESMTP id A5170DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 23:59:40 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so1665502wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 04:59:39 -0800 (PST)
Message-ID: <f87675ee0711290459r20aa606ak7b3be9d3b0a8ec1c@mail.gmail.com>
Date: Thu, 29 Nov 2007 07:59:33 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: The question about the high memory support on MPC8360?
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <474E6A58.2070200@gdatech.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <396305910.05464@tsinghua.org.cn> <474E6A58.2070200@gdatech.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 29, 2007 2:29 AM, vijay baskar <cn.vijaibaskar@gdatech.co.in> wrote:
>
>  How to make the linux find the total 2GB memory?
>
>
>         Hi Friend,
>
>  I hope u had tracked the conversion that has been going on. The max mem
> that the kernel can show is only 768 MB because only that of memory is
> directly mapped with your ram.. No matter how much ram > 768 MB (in
> powerpc.. it varies in other architectures) u have, the kernel will show
> only 768 MB.. This is called low mem..
>
>  How t o use high mem??
>
>  scott can probably guide us on this.. I also have lot of confusions about
> high mem.. Also i would suggest you a bit of reading on virtual memory
> management on linux to get a grasp about how things are done
>  Rest for scott
>
>  regards,
>  vijai
>

I also have a requirement to use more than 768MB and 0x30000000. I
have other problems at the moment, so I haven't tested this completely
yet. My limited understanding, though, is that to use more than 768MB
you have to change your kernel configuration, including shifting the
kernel start address. This is what I plan on testing for 1GB when I
have time:

CONFIG_ADVANCED_OPTIONS=y
CONFIG_LOWMEM_SIZE_BOOL=y
CONFIG_LOWMEM_SIZE=0x40000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=0xa0000000
# CONFIG_CONSISTENT_START_BOOL is not set
# CONFIG_CONSISTENT_SIZE_BOOL is not set
# CONFIG_BOOT_LOAD_BOOL is not set

If that works for current kernels, please respond to the list ;-) .

HTH,
Robert
