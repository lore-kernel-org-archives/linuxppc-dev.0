Return-Path: <cml3227@eircom.net>
Message-ID: <4179251F.90607@eircom.net>
Date: Fri, 22 Oct 2004 16:19:59 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB91@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB91@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: 
Subject: Re: CPM2 Bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune,

I don't think that there is a bug.
I have PCI working on an 8250 target.

The new structure agrees with the rev 1 of the MPC8xx manual.
The old structure agreed with the rev 0 manual (without PCI).

Conor

Rune Torgersen wrote:
> I think I found a bug in immap_cmp2.h
> 
> (in structue sit_cpm2_t)
> 
> I know that res7 was changed to make room for the PCI structure
> But res6 is 2 bytes shorter in the new one.
> 
> I compared to the same structure in u-boot (that got the PCI change at
> about the same time) and it has it at 94 bytes long also.
> 
> 
> Old structure:
>  /* System Integration Timers.
>  */
> typedef struct sys_int_timers {
> 	char	res1[32];
> 	ushort	sit_tmcntsc;
> 	char	res2[2];
> 	uint	sit_tmcnt;
> 	char	res3[4];
> 	uint	sit_tmcntal;
> 	char	res4[16];
> 	ushort	sit_piscr;
> 	char	res5[2];
> 	uint	sit_pitc;
> 	uint	sit_pitr;
> 	char	res6[94];
> 	char	res7[2390];
> } sit8260_t;
> 
> New structue:
> typedef struct sys_int_timers {
> 	u8	res1[32];
> 	u16	sit_tmcntsc;
> 	u8	res2[2];
> 	u32	sit_tmcnt;
> 	u8	res3[4];
> 	u32	sit_tmcntal;
> 	u8	res4[16];
> 	u16	sit_piscr;
> 	u8	res5[2];
> 	u32	sit_pitc;
> 	u32	sit_pitr;
> 	u8	res6[92];
> 	u8	res7[390];
> } sit_cpm2_t;
> 
> Rune Torgersen
> System Developer
> Innovative Systems LLC
> 1000 Innovative Drive
> Mitchell, SD 57301
> Ph: 605-995-6120
> www.innovsys.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
