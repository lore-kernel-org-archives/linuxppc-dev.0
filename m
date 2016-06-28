Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdsx36QQVzDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 14:18:15 +1000 (AEST)
Message-ID: <1467087495.29717.4.camel@neuling.org>
Subject: Re: [PATCH 07/17] powerpc/opal: Add real mode call wrappers
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: shreyas <shreyas@linux.vnet.ibm.com>
Date: Tue, 28 Jun 2016 14:18:15 +1000
In-Reply-To: <1467030333-31435-8-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
 <1467030333-31435-8-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpe,

Just flagging this as going to conflict with Shreyas' stop instruction
patch series. =C2=A0It's relatively easy to fix so you can do it manually.

Alternatively you could take this one patch now and get Shreyas to rebase.

Mikey

On Mon, 2016-06-27 at 22:25 +1000, Benjamin Herrenschmidt wrote:
> Replace the old generic opal_call_realmode() with proper per-call
> wrappers similar to the normal ones and convert callers.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> =C2=A0arch/powerpc/include/asm/opal-api.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 +++-
> =C2=A0arch/powerpc/include/asm/opal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06 =
+++
> =C2=A0arch/powerpc/kernel/idle_power7.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 16 ++-----
> =C2=A0arch/powerpc/platforms/powernv/opal-wrappers.S | 63 +++++++++++++--=
-----
> ------
> =C2=A04 files changed, 51 insertions(+), 44 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/opal-api.h
> b/arch/powerpc/include/asm/opal-api.h
> index 4b4b559..957795c 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -162,7 +162,8 @@
> =C2=A0#define	OPAL_INT_SET_CPPR			123
> =C2=A0#define OPAL_INT_EOI				124
> =C2=A0#define OPAL_INT_SET_MFRR			125
> -#define OPAL_LAST				125
> +#define OPAL_PCI_TCE_KILL			126
> +#define OPAL_LAST				126
> =C2=A0
> =C2=A0/* Device tree flags */
> =C2=A0
> @@ -895,6 +896,13 @@ enum {
> =C2=A0	OPAL_REBOOT_PLATFORM_ERROR	=3D 1,
> =C2=A0};
> =C2=A0
> +/* Argument to OPAL_PCI_TCE_KILL */
> +enum {
> +	OPAL_PCI_TCE_KILL_PAGES,
> +	OPAL_PCI_TCE_KILL_PE,
> +	OPAL_PCI_TCE_KILL_ALL,
> +};
> +
> =C2=A0#endif /* __ASSEMBLY__ */
> =C2=A0
> =C2=A0#endif /* __OPAL_API_H */
> diff --git a/arch/powerpc/include/asm/opal.h
> b/arch/powerpc/include/asm/opal.h
> index 6ccb847..ec6e0cc 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -214,6 +214,12 @@ int64_t opal_int_get_xirr(uint32_t *out_xirr, bool
> just_poll);
> =C2=A0int64_t opal_int_set_cppr(uint8_t cppr);
> =C2=A0int64_t opal_int_eoi(uint32_t xirr);
> =C2=A0int64_t opal_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
> +int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
> +			=C2=A0=C2=A0uint32_t pe_num, uint32_t tce_size,
> +			=C2=A0=C2=A0uint64_t dma_addr, uint32_t npages);
> +int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint32_t pe_num, uint32_t tce_size,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint64_t dma_addr, uint32_t npages);
> =C2=A0
> =C2=A0/* Internal functions */
> =C2=A0extern int early_init_dt_scan_opal(unsigned long node, const char
> *uname,
> diff --git a/arch/powerpc/kernel/idle_power7.S
> b/arch/powerpc/kernel/idle_power7.S
> index 470ceeb..c93f825 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
> @@ -196,8 +196,7 @@ fastsleep_workaround_at_entry:
> =C2=A0	/* Fast sleep workaround */
> =C2=A0	li	r3,1
> =C2=A0	li	r4,1
> -	li	r0,OPAL_CONFIG_CPU_IDLE_STATE
> -	bl	opal_call_realmode
> +	bl	opal_rm_config_cpu_idle_state
> =C2=A0
> =C2=A0	/* Clear Lock bit */
> =C2=A0	li	r0,0
> @@ -270,8 +269,7 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S,
> 66);		\
> =C2=A0	ld	r2,PACATOC(r13);				=09
> \
> =C2=A0	ld	r1,PACAR1(r13);				=09
> 	\
> =C2=A0	std	r3,ORIG_GPR3(r1);	/* Save original r3 */=09
> 	\
> -	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token
> argument*/	\
> -	bl	opal_call_realmode;				=09
> \
> +	bl	opal_rm_handle_hmi;				=09
> \
> =C2=A0	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */=09
> \
> =C2=A020:	nop;
> =C2=A0
> @@ -284,7 +282,7 @@ _GLOBAL(power7_wakeup_tb_loss)
> =C2=A0	=C2=A0* and they are restored before switching to the process
> context. Hence
> =C2=A0	=C2=A0* until they are restored, they are free to be used.
> =C2=A0	=C2=A0*
> -	=C2=A0* Save SRR1 in a NVGPR as it might be clobbered in
> opal_call_realmode
> +	=C2=A0* Save SRR1 in a NVGPR as it might be clobbered in opal call
> =C2=A0	=C2=A0* (called in CHECK_HMI_INTERRUPT). SRR1 is required to
> determine the
> =C2=A0	=C2=A0* wakeup reason if we branch to kvm_start_guest.
> =C2=A0	=C2=A0*/
> @@ -378,10 +376,7 @@ timebase_resync:
> =C2=A0	=C2=A0* set in exceptions-64s.S */
> =C2=A0	ble	cr3,clear_lock
> =C2=A0	/* Time base re-sync */
> -	li	r0,OPAL_RESYNC_TIMEBASE
> -	bl	opal_call_realmode;
> -	/* TODO: Check r3 for failure */
> -
> +	bl	opal_rm_resync_timebase;
> =C2=A0	/*
> =C2=A0	=C2=A0* If waking up from sleep, per core state is not lost, skip =
to
> =C2=A0	=C2=A0* clear_lock.
> @@ -469,8 +464,7 @@ hypervisor_state_restored:
> =C2=A0fastsleep_workaround_at_exit:
> =C2=A0	li	r3,1
> =C2=A0	li	r4,0
> -	li	r0,OPAL_CONFIG_CPU_IDLE_STATE
> -	bl	opal_call_realmode
> +	bl	opal_rm_config_cpu_idle_state
> =C2=A0	b	timebase_resync
> =C2=A0
> =C2=A0/*
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S
> b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 3854343..d5f00bb 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -59,7 +59,7 @@ END_FTR_SECTION(0, 1);				=09
> 	\
> =C2=A0#define OPAL_CALL(name, token)		\
> =C2=A0 _GLOBAL_TOC(name);			\
> =C2=A0	mflr	r0;			\
> -	std	r0,16(r1);		\
> +	std	r0,PPC_LR_STKOFF(r1);	\
> =C2=A0	li	r0,token;		\
> =C2=A0	OPAL_BRANCH(opal_tracepoint_entry) \
> =C2=A0	mfcr	r12;			\
> @@ -92,7 +92,7 @@ opal_return:
> =C2=A0	FIXUP_ENDIAN
> =C2=A0	ld	r2,PACATOC(r13);
> =C2=A0	lwz	r4,8(r1);
> -	ld	r5,16(r1);
> +	ld	r5,PPC_LR_STKOFF(r1);
> =C2=A0	ld	r6,PACASAVEDMSR(r13);
> =C2=A0	mtspr	SPRN_SRR0,r5;
> =C2=A0	mtspr	SPRN_SRR1,r6;
> @@ -157,43 +157,37 @@ opal_tracepoint_return:
> =C2=A0	blr
> =C2=A0#endif
> =C2=A0
> -/*
> - * Make opal call in realmode. This is a generic function to be called
> - * from realmode. It handles endianness.
> - *
> - * r13 - paca pointer
> - * r1=C2=A0=C2=A0- stack pointer
> - * r0=C2=A0=C2=A0- opal token
> - */
> -_GLOBAL(opal_call_realmode)
> -	mflr	r12
> -	std	r12,PPC_LR_STKOFF(r1)
> -	ld	r2,PACATOC(r13)
> -	/* Set opal return address */
> -	LOAD_REG_ADDR(r12,return_from_opal_call)
> -	mtlr	r12
> -
> -	mfmsr	r12
> -#ifdef __LITTLE_ENDIAN__
> -	/* Handle endian-ness */
> -	li	r11,MSR_LE
> -	andc	r12,r12,r11
> -#endif
> -	mtspr	SPRN_HSRR1,r12
> -	LOAD_REG_ADDR(r11,opal)
> -	ld	r12,8(r11)
> -	ld	r2,0(r11)
> -	mtspr	SPRN_HSRR0,r12
> +#define OPAL_CALL_REAL(name, token)			\
> + _GLOBAL_TOC(name);					\
> +	mflr	r0;					\
> +	std	r0,PPC_LR_STKOFF(r1);			\
> +	li	r0,token;				\
> +	mfcr	r12;					\
> +	stw	r12,8(r1);				\
> +							\
> +	/* Set opal return address */			\
> +	LOAD_REG_ADDR(r11, opal_return_realmode);	\
> +	mtlr	r11;					\
> +	mfmsr	r12;					\
> +	li	r11,MSR_LE;				\
> +	andc	r12,r12,r11;				\
> +	mtspr	SPRN_HSRR1,r12;				\
> +	LOAD_REG_ADDR(r11,opal);			\
> +	ld	r12,8(r11);				\
> +	ld	r2,0(r11);				\
> +	mtspr	SPRN_HSRR0,r12;				\
> =C2=A0	hrfid
> =C2=A0
> -return_from_opal_call:
> -#ifdef __LITTLE_ENDIAN__
> +opal_return_realmode:
> =C2=A0	FIXUP_ENDIAN
> -#endif
> +	ld	r2,PACATOC(r13);
> +	lwz	r11,8(r1);
> =C2=A0	ld	r12,PPC_LR_STKOFF(r1)
> +	mtcr	r11;
> =C2=A0	mtlr	r12
> =C2=A0	blr
> =C2=A0
> +
> =C2=A0OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
> =C2=A0OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE)
> ;
> =C2=A0OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
> @@ -271,6 +265,7 @@ OPAL_CALL(opal_validate_flash,		=09
> OPAL_FLASH_VALIDATE);
> =C2=A0OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
> =C2=A0OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
> =C2=A0OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEB
> ASE);
> +OPAL_CALL_REAL(opal_rm_resync_timebase,		OPAL_RESYNC_TIMEB
> ASE);
> =C2=A0OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
> =C2=A0OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
> =C2=A0OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
> @@ -285,7 +280,9 @@ OPAL_CALL(opal_sensor_read,			OP
> AL_SENSOR_READ);
> =C2=A0OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
> =C2=A0OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
> =C2=A0OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
> +OPAL_CALL_REAL(opal_rm_handle_hmi,		OPAL_HANDLE_HMI);
> =C2=A0OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDL
> E_STATE);
> +OPAL_CALL_REAL(opal_rm_config_cpu_idle_state,	OPAL_CONFIG_CPU_IDL
> E_STATE);
> =C2=A0OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
> =C2=A0OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_R
> EGION);
> =C2=A0OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DU
> MP_REGION);
> @@ -306,3 +303,5 @@ OPAL_CALL(opal_int_get_xirr,			O
> PAL_INT_GET_XIRR);
> =C2=A0OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
> =C2=A0OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
> =C2=A0OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
> +OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
> +OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
