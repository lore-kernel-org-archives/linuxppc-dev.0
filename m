Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7Tcr37PKzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 13:33:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, jk@ozlabs.org
Subject: Re: [PATCH] powerpc: opal-msglog: Report size of memcons log
In-Reply-To: <87bmuyb2i3.fsf@concordia.ellerman.id.au>
References: <20170113035349.15923-1-joel@jms.id.au>
 <87bmuyb2i3.fsf@concordia.ellerman.id.au>
Date: Wed, 25 Jan 2017 13:33:26 +1100
Message-ID: <874m0namx5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Joel Stanley <joel@jms.id.au> writes:
>
>> The OPAL memory console is reported to be size zero, as we do not
>> initialise the struct attr with any size information due to the size
>> being variable. This leads users to think that the console is empty.
>
> Hmm OK. That is a general property of /proc and /sys files that are
> dynamically generated, so users probably need to get used to it :)
>
>> Instead report the maximum size.
>
> But OK. That sounds sane enough. My only worry is that it might confuse
> some tools, ie. the file claims to be x bytes but is actually smaller.
> But I guess that can actually happen anyway with any file.
>
> So I'll merge this and stop blabbing :)

Hmm, but then I get:

  $ ls -la msglog 
  -r--r--r-- 1 root root 4503599627370496 Jan 25 13:09 msglog

I know firmware likes to spit out lots of messages, but 4PB seems a bit
large :P

I fixed it with the patch below which I'll fold in, resulting in:

  $ ls -la msglog 
  -r--r--r-- 1 root root 1048576 Jan 25 13:30 msglog


Which seems more likely.

cheers

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 8486b2ceb510..7a9cde0cfbd1 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -124,8 +124,8 @@ void __init opal_msglog_init(void)
 	}
 
 	/* Report maximum size */
-	opal_msglog_attr.size =  be64_to_cpu(mc->ibuf_size) +
-		be64_to_cpu(mc->obuf_size);
+	opal_msglog_attr.size =  be32_to_cpu(mc->ibuf_size) +
+		be32_to_cpu(mc->obuf_size);
 
 	opal_memcons = mc;
 }
