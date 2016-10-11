Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stQwV3NhxzDskc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 16:46:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jan Stancek <jstancek@redhat.com>, Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: ehea crash on boot
In-Reply-To: <20161010115102.GA501@dustball.brq.redhat.com>
References: <CAOJe8K0p60fmubbhSHCm0096CTjYjnnfoo_JLuwDcg6fo-=pBg@mail.gmail.com>
 <20161010115102.GA501@dustball.brq.redhat.com>
Date: Tue, 11 Oct 2016 16:46:31 +1100
Message-ID: <87insz5tfs.fsf@concordia.ellerman.id.au>
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

Jan Stancek <jstancek@redhat.com> writes:

> Hi Denis / all,
>
> Do you know if there is a patch or lead for this problem? I seem
> to be hitting same Oops with P730 lpar when running 4.8 (see below),
> but 4.7.7 looks OK.

Does this fix it?

cheers


diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 4cebc31e53de..4e83d872872d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -526,7 +526,7 @@ static bool might_have_hea(void)
 	 */
 #ifdef CONFIG_IBMEBUS
 	return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
-		!firmware_has_feature(FW_FEATURE_SPLPAR);
+		firmware_has_feature(FW_FEATURE_SPLPAR);
 #else
 	return false;
 #endif
