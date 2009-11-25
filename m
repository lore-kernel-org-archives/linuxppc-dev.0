Return-Path: <albert_herranz@yahoo.es>
Received: from smtp144.mail.ukl.yahoo.com (smtp144.mail.ukl.yahoo.com
	[77.238.184.75]) by ozlabs.org (Postfix) with SMTP id F289F100814
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:24:09 +1100 (EST)
Message-ID: <4B0D6837.4020407@yahoo.es>
Date: Wed, 25 Nov 2009 18:24:07 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 12/19] powerpc: gamecube: platform support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<F5450BB0-FBBB-48D5-A054-CB147FD43EAA@kernel.crashing.org>
In-Reply-To: <F5450BB0-FBBB-48D5-A054-CB147FD43EAA@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +static struct of_device_id gamecube_of_bus[] = {
>> +    { .compatible = "nintendo,flipper", },
>> +    { },
>> +};
>> +
>> +static int __init gamecube_device_probe(void)
>> +{
>> +    if (!machine_is(gamecube))
>> +        return 0;
>> +
>> +    of_platform_bus_probe(NULL, gamecube_of_bus, NULL);
>> +    return 0;
>> +}
> 
> You really do not need a platform bus as far as I can see?
> 

We need it as it currently doesn't match with the default bus ids.

const struct of_device_id of_default_bus_ids[] = {
        { .type = "soc", },
        { .compatible = "soc", },
        { .type = "plb5", },
        { .type = "plb4", },
        { .type = "opb", },
        { .type = "simple", },
        {},
};

Should I introduce a .type property matching any of those above in the soc node, and get rid of the explicit bus probe?

Thanks,
Albert
