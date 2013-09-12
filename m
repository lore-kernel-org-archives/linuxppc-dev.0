Return-Path: <matt@ozlabs.org>
References: <1378915410-2262-1-git-send-email-murzin.v@gmail.com>
 <7012.1378945979@ale.ozlabs.ibm.com>
In-Reply-To: <7012.1378945979@ale.ozlabs.ibm.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <79BD1567-A588-4977-BF11-C03045B55884@ozlabs.org>
From: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH] powerpc: net: filter: fix DIVWU instruction opcode
Date: Thu, 12 Sep 2013 10:28:03 +0930
To: Michael Neuling <mikey@neuling.org>
Cc: Vladimir Murzin <murzin.v@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12 Sep 2013, at 10:02, Michael Neuling <mikey@neuling.org> wrote:

> Vladimir Murzin <murzin.v@gmail.com> wrote:
>=20
>> Currently DIVWU stands for *signed* divw opcode:
>>=20
>> 7d 2a 4b 96    divwu   r9,r10,r9
>> 7d 2a 4b d6    divw    r9,r10,r9
>>=20
>> Use the *unsigned* divw opcode for DIVWU.
>=20
> This looks like it's in only used in the BPF JIT code. =20
>=20
> Matt, any chance you an ACK/NACK this?

Sure, that looks sensible, thanks Vladimir.=20

Acked-by: Matt Evans <matt@ozlabs.org>

>=20
> Mikey
>=20
>>=20
>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>> ---
>> arch/powerpc/include/asm/ppc-opcode.h |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include=
/asm/ppc-opcode.h
>> index d7fe9f5..c91842c 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -218,7 +218,7 @@
>> #define PPC_INST_MULLW            0x7c0001d6
>> #define PPC_INST_MULHWU            0x7c000016
>> #define PPC_INST_MULLI            0x1c000000
>> -#define PPC_INST_DIVWU            0x7c0003d6
>> +#define PPC_INST_DIVWU            0x7c000396
>> #define PPC_INST_RLWINM            0x54000000
>> #define PPC_INST_RLDICR            0x78000004
>> #define PPC_INST_SLW            0x7c000030
>> --=20
>> 1.7.10.4
>>=20
