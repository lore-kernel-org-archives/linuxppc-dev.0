Return-Path: <scott.wood@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0059.outbound.protection.outlook.com [157.56.112.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRYM45CvgzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 05:16:15 +1100 (AEDT)
From: Scott Wood <scott.wood@nxp.com>
To: Rob Herring <robh@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "Jochen
 Friedrich" <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 "Zhao Qiang" <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 "Santosh Shilimkar" <ssantosh@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: Re: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
Date: Fri, 18 Mar 2016 18:16:06 +0000
Message-ID: <HE1PR0401MB1931444381E249E41C45C748918C0@HE1PR0401MB1931.eurprd04.prod.outlook.com>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
 <20160317170640.GB21009@rob-hp-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/17/2016 12:06 PM, Rob Herring wrote:=0A=
> On Wed, Mar 09, 2016 at 06:08:49PM +0800, Yangbo Lu wrote:=0A=
>> Move guts devicetree doc to Documentation/devicetree/bindings/soc/fsl/=
=0A=
>> since it's used by not only PowerPC but also ARM. And add a specificatio=
n=0A=
>> for 'little-endian' property.=0A=
>>=0A=
>> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>=0A=
>> ---=0A=
>> Changes for v2:=0A=
>> 	- None=0A=
>> Changes for v3:=0A=
>> 	- None=0A=
>> Changes for v4:=0A=
>> 	- Added this patch=0A=
>> Changes for v5:=0A=
>> 	- Modified the description for little-endian property=0A=
>> Changes for v6:=0A=
>> 	- None=0A=
>> ---=0A=
>>  Documentation/devicetree/bindings/{powerpc =3D> soc}/fsl/guts.txt | 3 +=
++=0A=
>>  1 file changed, 3 insertions(+)=0A=
>>  rename Documentation/devicetree/bindings/{powerpc =3D> soc}/fsl/guts.tx=
t (91%)=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Do=
cumentation/devicetree/bindings/soc/fsl/guts.txt=0A=
>> similarity index 91%=0A=
>> rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt=0A=
>> rename to Documentation/devicetree/bindings/soc/fsl/guts.txt=0A=
>> index b71b203..07adca9 100644=0A=
>> --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt=0A=
>> +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt=0A=
>> @@ -25,6 +25,9 @@ Recommended properties:=0A=
>>   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN=
=0A=
>>     registers, for those SOCs that have a PAMU device.=0A=
>>  =0A=
>> + - little-endian : Indicates that the global utilities block is little=
=0A=
>> +   endian. The default is big endian.=0A=
> =0A=
> The default is "the native endianness of the system". So absence on an =
=0A=
> ARM system would be LE.=0A=
=0A=
No.  For this binding, the default is big-endian, because that's what=0A=
existed for this device before an endian property was added.=0A=
=0A=
"endianness of the system" is not a well-defined concept.=0A=
=0A=
> This property is valid for any simple-bus device, =0A=
=0A=
Since when does simple-bus mean anything more than that the nodes=0A=
underneath it can be used without bus-specific knowledge?=0A=
=0A=
> so it isn't really required to document per device. You can, but =0A=
> your description had better match the documented behaviour.=0A=
=0A=
Documented where?=0A=
=0A=
In fact, Documentation/devicetree/bindings/common-properties.txt=0A=
explicitly says of the endian properties, "If a binding supports these=0A=
properties, then the binding should also specify the default behavior if=0A=
none of these properties are present."=0A=
=0A=
-Scott=0A=
=0A=
