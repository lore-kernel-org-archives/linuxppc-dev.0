Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 5FFADB7D6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 May 2010 21:20:46 +1000 (EST)
Message-ID: <4BF66C8B.10407@mlbassoc.com>
Date: Fri, 21 May 2010 05:20:43 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: hellohello <hellohello008@163.com>
Subject: Re: Problem of PowerPc 82xx  when using smc
References: <042201caf7fa$9d038a20$a51cbcc0@sfdomain.com>	<20100520170608.GA10712@schlenkerla.am.freescale.net>
	<051501caf896$5c954630$a51cbcc0@sfdomain.com>
In-Reply-To: <051501caf896$5c954630$a51cbcc0@sfdomain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2010 09:33 PM, hellohello wrote:
>> No, it shouldn't -- rx_bd_base is of type "cbd_t *", so the multiplication
>> already happens as part of pointer arithmetic.
> ---Yes, you are right. I made a basic mistake.
>
> But now I have another question.
> The SMC1 params can be relocated to any offset of the DPRAM on a 64 byte boundary, not as the SCC1, which must be  at 0x8000 offset of the DPRAM.
> The SMC1 params base is set at 0x87FC offset of the DPRAM.
>
> So if  I want SMC1 params start at  0x200 in DPRAM  , I should set 0x200 to the 0x87FC offset of the DPRAM.
> I have see this code in u-boot, but I can not find this code in neither cpm_uart_cpm2.c nor cpm_uart_core.c.
>
> Should I add these code to  cpm_uart_core.c?
>
> --dp_mem = cpm_dpram_addr(0x87fc);
> --out_be16(dp_mem, SMC1_BASE);

Why are you mucking about with this code at all?  SMCx serial certainly
works on every platform I've ever used, 8xx and 8xxx as well.

> ----- Original Message -----
> From: "Scott Wood"<scottwood@freescale.com>
> To: "hellohello"<hellohello008@163.com>
> Cc:<linuxppc-dev@lists.ozlabs.org>
> Sent: Friday, May 21, 2010 1:06 AM
> Subject: Re: Problem of PowerPc 82xx when using smc
>
>
>> On Thu, May 20, 2010 at 04:58:27PM +0800, hellohello wrote:
>>>
>>> I find a problem in
>>> drivers/serial/cpm_uart/cpm_uart_cpm2.c:
>>> int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
>>> {
>>> ... ...
>>> pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
>>> /*The above line should be ：*/
>>>   pinfo->tx_bd_base = pinfo->rx_bd_base + sizeof(cbd_t) * pinfo->rx_nrfifos;
>>
>> No, it shouldn't -- rx_bd_base is of type "cbd_t *", so the multiplication
>> already happens as part of pointer arithmetic.
>>
>>> return 0;
>>> }
>>>
>>> Where to get the newest code for kernel?
>>
>> git.kernel.org
>>
>>> How to know whether it is already patched by anyone else?  Just search in  this mail list?
>>
>> As well as the current git tree.
>>
>> -Scott
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
