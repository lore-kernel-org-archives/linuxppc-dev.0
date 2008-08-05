Return-Path: <jrigby@freescale.com>
Message-ID: <4898C34C.5000305@freescale.com>
Date: Tue, 05 Aug 2008 15:17:00 -0600
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias to
	MPC5121 ADS device tree.
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>	
	<1217967220-30557-2-git-send-email-jrigby@freescale.com>	
	<fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>
	<fa686aa40808051405j7ea96957t9242e007c93d8e74@mail.gmail.com>
In-Reply-To: <fa686aa40808051405j7ea96957t9242e007c93d8e74@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Uncle!

U-boot:

    The 5121 currently fixes up the soc's bus-frequency node with a hard
    coded path.
    I'll leave it that way.

Kernel:

    I would like to use mpc83xx_add_bridge for 5121.  This is why I
    moved it to fsl_pci.c.  It currently uses get_immrbase and adds
    0x8300 and 0x8304 to it to pass to setup_indirect_pci as the
    cfg_addr, and cfg_data addresses.

    I'm more than willing to change mpc83xx_add_bridge to not use
    get_immrbase.  One simple solution is to pass the cfg_addr and
    cfg_data addresses in.  If that seems ok then thats what I will do.

John






Grant Likely wrote:
> Oops, forgot to add devicetree-discuss to the cc: list
>
> g.
>
> On Tue, Aug 5, 2008 at 3:05 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>   
>> On Tue, Aug 5, 2008 at 2:13 PM, John Rigby <jrigby@freescale.com> wrote:
>>     
>>> So get_immrbase can function without a device_type = "soc"
>>> property in the soc node.
>>>
>>> The "soc" node should really be named "immr"
>>> because it does not include the entire soc, however
>>> u-boot currently looks up this node by name for
>>> a clock fixup so leave it "soc" for now.  We will change
>>> it later after 5121 u-boot uses the immr alias instead
>>> of the node name.
>>>       
>> Is it not sufficient to search the tree for a node with the
>> <chip>-immr compatible value?  I don't think this is the intended use
>> case of aliases.
>>
>> g.
>>
>> --
>> Grant Likely, B.Sc., P.Eng.
>> Secret Lab Technologies Ltd.
>>
>>     
>
>
>
>   
