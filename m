Return-Path: <dbeamonte@telnet-ri.es>
Received: from smtp242.efor.es (leela.efor.es [195.55.174.242])
	by ozlabs.org (Postfix) with ESMTP id 8B994DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 16:20:59 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by leela.efor.es (Postfix) with ESMTP id C7C8515F694
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 08:20:56 +0200 (CEST)
Received: from [192.168.200.117] (unknown [213.0.25.185])
	by leela.efor.es (Postfix) with ESMTP id DEAF815F6B0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 08:20:52 +0200 (CEST)
Message-ID: <48C61522.6010109@telnet-ri.es>
Date: Tue, 09 Sep 2008 08:18:10 +0200
From: David Beamonte <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Host USB issue on MPC8272
References: <48C0DD6F.8070205@telnet-ri.es> <48C14D77.4040001@freescale.com>
	<48C535B0.7090200@telnet-ri.es>
In-Reply-To: <48C535B0.7090200@telnet-ri.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anybody had a similar problem accessing external memory from CPMs?

Any idea on something I can try?

What is more critical? Accessing slow or quick external devices?

David


David Beamonte escribió:
> I have checked that bit and it is not set. In fact, that register has 
> the same value as the one in our ADS8272 (0x100c0000), which works.
>
> Anyway, it must be an issue of this kind, from the beginning I have 
> thought that we have a problem of arbitration of the bus that makes 
> the processor hang when the CPMs try to access external memory. Can it 
> be a problem of SDRAM configuration, wait-states or refresh times?
>
> Thanks Scott,
>
> David
>
>
> Scott Wood escribió:
>> David Beamonte wrote:
>>> This issue seems to be related to one problem that we have always 
>>> had. We can't configure buffers of SMCs, SCCs, etc, to be in SDRAM, 
>>> because the processor hangs. We always have to configure buffers in 
>>> DPRAM. In other drivers this has not been a problem, because the 
>>> buffer size is not very large, so we can allocate it in DPRAM, but 
>>> for this one, the buffer size is 0x8000 (32Kb) which exceeds DPRAM 
>>> size.
>>>
>>> Has anybody had the same problem? Can it be an USB specific problem 
>>> or a general one?
>>
>> Make sure that BCR[PLDP] is not set, as per erratum SIU18.
>>
>> -Scott
>>
>
>
