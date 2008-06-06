Return-Path: <wg@grandegger.com>
Message-ID: <4848F133.20704@grandegger.com>
Date: Fri, 06 Jun 2008 10:11:31 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>,  Linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 1/4] [POWERPC] 85xx: correct vendor prefix in DTS	files
	for TQM85xx modules
References: <48481DFE.6030405@grandegger.com>
	<20080606035911.GB6506@yookeroo.seuss>
In-Reply-To: <20080606035911.GB6506@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Jun 05, 2008 at 07:10:22PM +0200, Wolfgang Grandegger wrote:
>> Like for the TQM5200, the vendor prefix "tqc," is now used for all
>> TQM85xx modules from TQ-Components GmbH (http://www.tqc.de) in the
>> corresponding DTS files.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  arch/powerpc/boot/dts/tqm8540.dts     |    4 ++--
>>  arch/powerpc/boot/dts/tqm8541.dts     |    4 ++--
>>  arch/powerpc/boot/dts/tqm8555.dts     |    4 ++--
>>  arch/powerpc/boot/dts/tqm8560.dts     |    4 ++--
>>  arch/powerpc/platforms/85xx/tqm85xx.c |    8 ++++----
>>  5 files changed, 12 insertions(+), 12 deletions(-)
>>
>> Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8540.dts
>> ===================================================================
>> --- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8540.dts
>> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8540.dts
>> @@ -12,8 +12,8 @@
>>  /dts-v1/;
>>  
>>  / {
>> -	model = "tqm,8540";
>> -	compatible = "tqm,8540", "tqm,85xx";
>> +	model = "tqc,8540";
>> +	compatible = "tqc,8540", "tqc,85xx";
> 
> Hrm.  compatible strings with "xx" type wildcards in them should be
> avoided.  Keeping them for compatibility with existing code or trees
> is fine, but given that you're changing the name anyway, you should
> get rid of the 85xx reference.  Either just dropping it, if it's not
> actually used, or replacing with a defined name or the specific model
> of the earliest board this series is compatible with.

$ grep 85xx *.dts
mpc8540ads.dts: compatible = "MPC8540ADS", "MPC85xxADS";
mpc8541cds.dts: compatible = "MPC8541CDS", "MPC85xxCDS";
mpc8544ds.dts:  compatible = "MPC8544DS", "MPC85xxDS";
mpc8548cds.dts: compatible = "MPC8548CDS", "MPC85xxCDS";
mpc8555cds.dts: compatible = "MPC8555CDS", "MPC85xxCDS";
mpc8560ads.dts: compatible = "MPC8560ADS", "MPC85xxADS";
mpc8568mds.dts: compatible = "MPC8568EMDS", "MPC85xxMDS";
tqm8540.dts:    compatible = "tqc,8540", "tqc,85xx";
tqm8541.dts:    compatible = "tqc,8541", "tqc,85xx";
tqm8548-bigflash.dts:   compatible = "tqc,8548", "tqc,85xx";
tqm8555.dts:    compatible = "tqc,8555", "tqc,85xx";
tqm8560.dts:    compatible = "tqc,8560", "tqc,85xx";

The 85xx wildcard seems to be used for other devices as well. It's fine
for me removing "tqc,85xx". Furthermore I just realize, that the "tqm"
prefix is missing in the board names. The correct properties should then
look like:

	model = "tqc,tqm8540";
	compatible = "tqc,tqm8540";

Going to prepare new patches now.

Wolfgang.
