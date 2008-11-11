Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 8A6A3DDDE0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 00:21:52 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1056030yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 05:21:45 -0800 (PST)
Date: Tue, 11 Nov 2008 08:19:37 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
Message-ID: <20081111131937.GA2875@yoda.jdub.homelinux.org>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<48FF3889.2030304@linux.vnet.ibm.com>
	<fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: dzu@denx.de, Ilya Yanok <yanok@emcraft.com>, linuxppc-dev@ozlabs.org,
	Hollis Blanchard <hollisb@us.ibm.com>, pvr@emcraft.com,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 06:23:28PM -0500, Hollis Blanchard wrote:
>On Wed, Oct 22, 2008 at 9:28 AM, Christian Ehrhardt
><ehrhardt@linux.vnet.ibm.com> wrote:
>> Hi Ilya,
>> I just tried your patch on my 440 board because it would help us in our
>> environment.
>> Unfortunately I run into a bug on early boot (mark_bootmem).
>>
>> A log can be found in this mail, this is the bug when running with 64k page
>> size.
>> I tried this with and without your 2/2 265k patch and also with page size
>> configured to 16k, the error is the same in all cases.
>>
>> I used an earlier version of your patch in the past and it worked fine.
>> Applying this old patch causes the same problem.
>> Therefore I expect that there was some other code changed that breaks with
>> page size != 4k.
>
>This patch seems to solve the problem for me, but I have to run and
>haven't yet worked out if it's the right fix.
>
>diff --git a/mm/bootmem.c b/mm/bootmem.c
>--- a/mm/bootmem.c
>+++ b/mm/bootmem.c
>@@ -300,7 +300,7 @@ static int __init mark_bootmem(unsigned
>                unsigned long max;
>
>                if (pos < bdata->node_min_pfn ||
>-                   pos >= bdata->node_low_pfn) {
>+                   pos > bdata->node_low_pfn) {
>                        BUG_ON(pos != start);
>                        continue;
>                }
>@@ -399,7 +399,7 @@ int __init reserve_bootmem(unsigned long
>        unsigned long start, end;
>
>        start = PFN_DOWN(addr);
>-       end = PFN_UP(addr + size);
>+       end = PFN_DOWN(addr + size);
>
>        return mark_bootmem(start, end, 1, flags);
> }


Hollis,  if I'm understanding things correctly this patch is no
longer needed if we do the memory reserve in the boot wrapper for
the errata.  Correct?

josh
