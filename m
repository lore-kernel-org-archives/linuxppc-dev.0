Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id 917822C0141
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 20:49:27 +1100 (EST)
Message-ID: <515AA9A2.1090100@sirius-es.it>
Date: Tue, 02 Apr 2013 11:49:22 +0200
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/3] powerpc/mpc512x: add platform code for MPC5125.
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <1363801314-16967-4-git-send-email-matteo.facchinetti@sirius-es.it>
 <20130330233241.25846714@crub>
In-Reply-To: <20130330233241.25846714@crub>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2013 11:32 PM, Anatolij Gustschin wrote:
>> +{
>> +	char *psc_compats[] = {
>> +		"fsl,mpc5121-psc",
>> +		"fsl,mpc5125-psc"
>> +	};
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(psc_compats); i++)
>> +		if (of_find_compatible_node(NULL, NULL, psc_compats[i]))
>> +			return psc_compats[i];
> I don't like this, better would be to use something like:
>
>          if (of_machine_is_compatible("fsl,mpc5121"))
>                  return "fsl,mpc5121-psc";
>
>          if (of_machine_is_compatible("fsl,mpc5125"))
>                  return "fsl,mpc5125-psc";
>
> but note that it will only work if we add these compatibles
> to the compatible list of the root nodes in 5121 and 5125
> device trees.

I agree with you.

But I don't like that:
"fsl,mpc5121" is already present in <mpc5121.dtsi> and after its 
inclusion in <mpc5121ads.dts> , compatible root node value is replaced 
by "fsl,mpc5121ads".

Idea is automatically generate
     compatible = "fsl,mpc5121", "fsl,mpc5121ads";
using dtsi hierarchy.

Is there a way to extend compatible values instead of replace it?

Matteo
