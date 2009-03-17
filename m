Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 15161DDF1C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 15:44:00 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1640074yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 21:43:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40903162054v2d28fc2er53aa4f71837110a2@mail.gmail.com>
References: <20090311222615.63410@gmx.net>
	<1237197925-71727-1-git-send-email-kosmo@semihalf.com>
	<fa686aa40903162054v2d28fc2er53aa4f71837110a2@mail.gmail.com>
Date: Mon, 16 Mar 2009 22:43:58 -0600
Message-ID: <fa686aa40903162143j5f641d7dob53b96b681737e07@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Enable CPU_FTR_NEED_COHERENT for MPC52xx
From: Grant Likely <grant.likely@secretlab.ca>
To: Piotr Ziecik <kosmo@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2009 at 9:54 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Mon, Mar 16, 2009 at 4:05 AM, Piotr Ziecik <kosmo@semihalf.com> wrote:
>> BestComm, a DMA engine in MPC52xx SoC, requires snooping when
>> CPU caches are enabled to work properly.
>>
>> Adding CPU_FTR_NEED_COHERENT fixes NFS problems on MPC52xx machines
>> introduced by 'powerpc/mm: Fix handling of _PAGE_COHERENT in BAT setup c=
ode'.
>>[...]
>> =A0#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
>> - =A0 =A0 =A0 || defined(CONFIG_PPC_83xx) || defined(CONFIG_8260)
>> + =A0 =A0 =A0 || defined(CONFIG_PPC_83xx) || defined(CONFIG_8260) \
>> + =A0 =A0 =A0 || defined(CONFIG_PPC_MPC52xx)
>> =A0#define CPU_FTR_COMMON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CPU_FTR_NEE=
D_COHERENT
>> =A0#else
>> =A0#define CPU_FTR_COMMON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>
> Aside from the fact that MPC10X_BRIDGE, PPC83xx and 8260 are already
> doing it, adding the feature bit this way isn't multiplatform
> friendly. =A0Essentially it means that all selected platforms will have
> CPU_FTR_NEED_COHERENT enabled if CONFIG_PPC_MPC52xx is enabled.

Here's my counter-patch.  It contains the change to just G2_LE cores
when MPC52xx is selected.  However, this change will also affect some
of the MPC82xx parts.  However CPU_FTR_NEED_COHERENT shouldn't
actually hurt anything, so maybe it would be better to just enable it
unconditionally for the G2_LE core.

Kumar/Ben, thoughts?

g.

---

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm=
/cput
index 4911104..48d7f5f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -348,8 +348,15 @@ extern const char *powerpc_base_platform;
            CPU_FTR_PPC_LE | CPU_FTR_NEED_PAIRED_STWCX)
 #define CPU_FTRS_82XX  (CPU_FTR_COMMON | \
            CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
+
+#if defined(CONFIG_PPC_MPC52xx)
+#define CPU_FTRS_G2_LE (CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
+           CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NEED_COHERENT)
+#else
 #define CPU_FTRS_G2_LE (CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
            CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP)
+#endif
+
 #define CPU_FTRS_E300  (CPU_FTR_MAYBE_CAN_DOZE | \
            CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | \
            CPU_FTR_COMMON)




--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
