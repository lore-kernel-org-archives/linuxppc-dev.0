Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C148DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:55:10 +1100 (EST)
Message-ID: <47967436.9070704@freescale.com>
Date: Tue, 22 Jan 2008 16:54:46 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3 v3] Add StorCenter DTS first draft.
References: <E1JHRkS-0005du-O1@jdl.com>
	<fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
In-Reply-To: <fa686aa40801221449p28889ea5r68bd726726558dc0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 1/22/08, Jon Loeliger <jdl@jdl.com> wrote:
>> Based on the Kurobox DTS files.
>>
>> Signed-off-by: Andy Wilcox <andy@protium.com>
>> Signed-off-by: Jon Loeliger <jdl@jdl.com>
> 
> Comments below
> 
>> +
>> +/ {
>> +       model = "StorCenter";
>> +       compatible = "storcenter";
> 
> Be specific!  "iomega,storcenter".  Even better if you put in the model number.

As I mentioned vefore, there is no further model number.
That _is_ the model name.

>> +
>> +       soc@fc000000 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               device_type = "soc";
> 
> device_type should be dropped (but I know that requires changes to the
> existing mpc82xx support code).

And when the code is fixed, we can fix the DTS too... :-)

>> +               compatible = "fsl,mpc8241", "mpc10x";
> 
> fsl,mpc8241-immr would be better; this node describes the internally
> memory mapped registers; not the entire soc.

Uh, whatever? :-)  'Cuz how many other DTS files say that?

>> +
>> +               mpic: interrupt-controller@40000 {
>> +                       #interrupt-cells = <2>;
>> +                       #address-cells = <0>;
> 
> Is #address-cells needed?  There are no child nodes.

I thought so.  Could be wrong.

>> +       chosen {
>> +               linux,stdout-path = "/soc/serial@4500";
> 
> /soc@fc000000/ perhaps?

Not really necessary to specify the unit number.

jdl
