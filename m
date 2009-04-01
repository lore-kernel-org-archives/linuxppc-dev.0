Return-Path: <wg@grandegger.com>
Message-ID: <49D35728.1060107@grandegger.com>
Date: Wed, 01 Apr 2009 13:59:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org
Subject: Re: [PATCH 6/8] --- arch/powerpc/boot/dts/socrates.dts | 9	+++++++--
	1 file changed, 7 insertions(+), 2 deletions(-)
References: <20090331123727.853787299@denx.de>
	<20090331124036.057237866@denx.de>
	<20090331230451.GA23304@yookeroo.seuss>
	<49D31856.9060808@grandegger.com>
	<20090401110955.GA7507@yookeroo.seuss>
In-Reply-To: <20090401110955.GA7507@yookeroo.seuss>
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
> On Wed, Apr 01, 2009 at 09:31:34AM +0200, Wolfgang Grandegger wrote:
>> Hi David,
>>
>> this patch went out by mistake, sorry.
>>
>> David Gibson wrote:
>>> On Tue, Mar 31, 2009 at 02:37:33PM +0200, Wolfgang Grandegger wrote:
>>>> Index: linux-2.6/arch/powerpc/boot/dts/socrates.dts
>>>> ===================================================================
>>>> --- linux-2.6.orig/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:24:38.078719288 +0200
>>>> +++ linux-2.6/arch/powerpc/boot/dts/socrates.dts	2009-03-31 13:47:56.986720719 +0200
>>>> @@ -52,6 +52,7 @@
>>>>  	soc8544@e0000000 {
>>>>  		#address-cells = <1>;
>>>>  		#size-cells = <1>;
>>>> +		device_type = "soc";
>>> You should not be adding device_type to a new board's dts.  You
>>> *especially* shouldn't be doing that with no patch comment explaining
>>> why.
>> In the final patch I have removed the device_type = "soc", but it makes
>> trouble as some mpc85xx rely on it.
> 
> Um.. what?  Some mpc85xx?  This is the dts for *one specific board*, I
> don't see how something that affects "some mpc85xx" is relevant.

Well, to be more precise, it affects all boards using CONFIG_FSL_SOC
because they use functions searching for the device type "soc", e.g.
fsl_get_sys_freq():

http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80

This needs to be fixed before the line 'device_type = "soc"' can be removed.

Wolfgang.
