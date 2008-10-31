Return-Path: <slightlyunconventional@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id B0F87DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Nov 2008 10:23:30 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so614820ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 16:23:29 -0700 (PDT)
Message-ID: <fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
Date: Fri, 31 Oct 2008 18:23:28 -0500
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: "Christian Ehrhardt" <ehrhardt@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
In-Reply-To: <48FF3889.2030304@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<48FF3889.2030304@linux.vnet.ibm.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, dzu@denx.de, linuxppc-dev@ozlabs.org,
	pvr@emcraft.com, Ilya Yanok <yanok@emcraft.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 22, 2008 at 9:28 AM, Christian Ehrhardt
<ehrhardt@linux.vnet.ibm.com> wrote:
> Hi Ilya,
> I just tried your patch on my 440 board because it would help us in our
> environment.
> Unfortunately I run into a bug on early boot (mark_bootmem).
>
> A log can be found in this mail, this is the bug when running with 64k page
> size.
> I tried this with and without your 2/2 265k patch and also with page size
> configured to 16k, the error is the same in all cases.
>
> I used an earlier version of your patch in the past and it worked fine.
> Applying this old patch causes the same problem.
> Therefore I expect that there was some other code changed that breaks with
> page size != 4k.

This patch seems to solve the problem for me, but I have to run and
haven't yet worked out if it's the right fix.

diff --git a/mm/bootmem.c b/mm/bootmem.c
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -300,7 +300,7 @@ static int __init mark_bootmem(unsigned
                unsigned long max;

                if (pos < bdata->node_min_pfn ||
-                   pos >= bdata->node_low_pfn) {
+                   pos > bdata->node_low_pfn) {
                        BUG_ON(pos != start);
                        continue;
                }
@@ -399,7 +399,7 @@ int __init reserve_bootmem(unsigned long
        unsigned long start, end;

        start = PFN_DOWN(addr);
-       end = PFN_UP(addr + size);
+       end = PFN_DOWN(addr + size);

        return mark_bootmem(start, end, 1, flags);
 }

Looks like the breakage may have been accidentally introduced by
Johannes Weiner <hannes@saeurebad.de> on Jul 24 (post 2.6.26).

FWIW, the boards Christian and I are hitting the problem on are
Sequoias with 256MB of RAM. cuImage is reporting only 0xffff000 bytes
of RAM though, which may be exacerbating the situation.

-Hollis
