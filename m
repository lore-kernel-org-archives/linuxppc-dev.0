Return-Path: <gregory.0xf0@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tsxZ46L4bzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 12:44:12 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id 41so32927758qtn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 17:44:12 -0800 (PST)
MIME-Version: 1.0
From: Gregory Fong <gregory.0xf0@gmail.com>
Date: Mon, 2 Jan 2017 17:43:36 -0800
Message-ID: <CADtm3G6VVthsOX7d_LHNtFdCvw+oiku=ATL8J-cBHBpLTVrpyg@mail.gmail.com>
Subject: mpic IRQ_TYPE_BOTH handling
To: linuxppc-dev@lists.ozlabs.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

In arch/powerpc/sysdev/mpic.c , it looks like IRQ_TYPE_EDGE_BOTH is
handled the same way as IRQ_TYPE_EDGE_FALLING:

static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
{
        /* Now convert sense value */
        switch(type & IRQ_TYPE_SENSE_MASK) {
        case IRQ_TYPE_EDGE_RISING:
                return MPIC_INFO(VECPRI_SENSE_EDGE) |
                       MPIC_INFO(VECPRI_POLARITY_POSITIVE);
        case IRQ_TYPE_EDGE_FALLING:
        case IRQ_TYPE_EDGE_BOTH:
                return MPIC_INFO(VECPRI_SENSE_EDGE) |
                       MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
        case IRQ_TYPE_LEVEL_HIGH:
                return MPIC_INFO(VECPRI_SENSE_LEVEL) |
                       MPIC_INFO(VECPRI_POLARITY_POSITIVE);
        case IRQ_TYPE_LEVEL_LOW:
        default:
                return MPIC_INFO(VECPRI_SENSE_LEVEL) |
                       MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
        }
}

If IRQ_TYPE_EDGE_BOTH is unsupported, shouldn't we be returning an
error, instead of silently setting to use IRQ_TYPE_EDGE_FALLING?
Something like the following (sorry if the diff wraps weirdly, on
webmail at the moment):

----8<----
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b9aac95..5867ea2 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -876,6 +876,9 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
int flow_type)
        if (src >= mpic->num_sources)
                return -EINVAL;

+       if (flow_type & IRQ_TYPE_SENSE_MASK == IRQ_TYPE_EDGE_BOTH)
+               return -EINVAL;
+
        vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));

        /* We don't support "none" type */
---->8----

Thanks,
Gregory
