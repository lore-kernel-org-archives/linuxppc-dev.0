Return-Path: <wg@grandegger.com>
Message-ID: <48D24CFA.3040604@grandegger.com>
Date: Thu, 18 Sep 2008 14:43:38 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Li Yang-R58472 <LeoLi@freescale.com>
Subject: Re: UCC GETH does not work on my MPC8360EA
References: <48D0CB3C.7050708@grandegger.com>
	<113760FDF39C3E40AAB8DE6E6C64D0A7110901@zch01exm26.fsl.freescale.net>
In-Reply-To: <113760FDF39C3E40AAB8DE6E6C64D0A7110901@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang-R58472 wrote:
>> -----Original Message-----
>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org 
>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] 
>> On Behalf Of Wolfgang Grandegger
>> Sent: Wednesday, September 17, 2008 5:18 PM
>> To: linuxppc-dev
>> Subject: UCC GETH does not work on my MPC8360EA 
>>
>> Hello,
>>
>> I have a wired problems with my MPC8360EA using Linux 
>> 2.6.27-rc6. The UCC GEHT controller works fine with 100/Full 
>> but fails with 1000/Full.
>> What I see is that the TX done interrupts come (ifconfig's TX 
>> packet counter goes up), but the messages does not show up on 
>> the wire. RX seems to work properly, though.
>>
>> Any idea what's going wrong? Does someone got it working with 
>> 1000/Full?
> 
> This looks like an old problem that RGMII Tx shouldn't use internal
> delay while Rx should use.  So try to use 'rgmii-rxid' as
> phy-connection-type in device tree.  Also there should have been a fixup
> in u-boot for this.  So update to use latest u-boot might fix your
> problem.

I do not have problems with U-Boot using 1000/full. The DTS property

  phy-connection-type = "rgmii-rxid"

fixed the problem wuth Linux, indeed, but I realize slow boot over NFS
and sometimes I even get "nfs server not responding" with that setting.

Wolfgang.
