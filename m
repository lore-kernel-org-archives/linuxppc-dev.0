Return-Path: <amodra@gmail.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A3D0A2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 14:32:20 +1000 (EST)
Received: by mail-ie0-f172.google.com with SMTP id c10so1081379ieb.17
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 21:32:16 -0700 (PDT)
Date: Tue, 20 Aug 2013 14:02:11 +0930
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: BUG_ON and gcc don't mix
Message-ID: <20130820043211.GC3430@bubble.grove.modra.org>
References: <20130820123750.7353f2f1@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130820123750.7353f2f1@kryten>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, wschmidt@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 20, 2013 at 12:37:50PM +1000, Anton Blanchard wrote:
> address of the trap instruction for our bug exception table. Maybe
> we need a gcc builtin in which we can get a label on the trap
> instruction. Would that be possible?

Not your actual _EMIT_BUG_ENTRY, but something like this ought to work.
The only trick here is not putting anything after __builtin_trap()..

#define BUG_ON(x) do { \
	if (x) {					\
		__asm__ __volatile__ ("\n1:"		\
			"\t.section __bug_table,\"a\""	\
			"\n\t.long 1b"			\
			"\n\t.previous");		\
                __builtin_trap();			\
	}						\
} while (0)

int foo(unsigned int *bar)
{
        unsigned int holder_cpu;

        holder_cpu = *bar & 0xffff;
        BUG_ON(holder_cpu >= 32);

        return 1;
}

-- 
Alan Modra
Australia Development Lab, IBM



-- 
Alan Modra
Australia Development Lab, IBM
