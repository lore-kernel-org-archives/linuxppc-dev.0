Return-Path: <jk@bilbo.ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc/spufs: Fix incorrect buffer offset
	in regs write
Date: Thu, 5 Mar 2009 10:32:35 +1100
References: <1236145172.189228.314429009881.1.gpush@pingu>
	<alpine.LRH.2.00.0903040935560.2416@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0903040935560.2416@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903051032.36358.jk@ozlabs.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Geert,

> Could this be abused by an attacker to write registers or local store
> he's not allowed to do?

It looks like the user can only overwrite fields that it already has 
access to. There's struct spu_lscsa:

struct spu_lscsa {
	struct spu_reg128 gprs[128];
	struct spu_reg128 fpcr;
	struct spu_reg128 decr;
	struct spu_reg128 decr_status;
	struct spu_reg128 ppu_mb;
	struct spu_reg128 ppuint_mb;
	struct spu_reg128 tag_mask;
	struct spu_reg128 event_mask;
	struct spu_reg128 srr0;
	struct spu_reg128 stopped_status;
	unsigned char ls[LS_SIZE] __attribute__((aligned(65536)));
};

where spu_reg128 is a u32[4].

The maximum 'allowed' write offset to the regs file is 2047. The 
(incorrect) maximum offset calculated by the old code would be 8188 
(2047 * 4) bytes into struct spu_lscsa.

So, 8188 bytes covers all of the registers, but ends somewhere before 
the start of the ls area (within the ls alignment padding). Let's look 
at the registers:

gprs:			user-writable
fpcr:			user-writable
decr:			user-writable
decr_status:	only affects user-settable SPE state
ppu_mb:		only affects user-settable SPE state
ppuint_mb:		only affects user-settable SPE state
tag_mask:		only affects user-settable SPE state
event_mask:	only affects user-settable SPE state
srr0:			only affects user-settable SPE state
stopped_status: only affects user-settable SPE state

So, I think we're fine. All a user can do with this bug is mess up their 
own SPE state.

> Should it be backported to stable?

Yes, I'll submit to the stable tree too.

Cheers,


Jeremy
