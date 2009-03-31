Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5820FDDEEA
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 20:35:38 +1100 (EST)
Message-ID: <49D1E3E5.3080607@grandegger.com>
Date: Tue, 31 Mar 2009 11:35:33 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
In-Reply-To: <fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> I agree 100% with David's comments, and I have some additional ones below.
> 
> On Thu, Mar 19, 2009 at 9:26 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> +       soc8544@e0000000 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               device_type = "soc";
> 
> Drop device_type here too.

Grrr, I just realized that removing the devices type "soc" has broken
fsl_get_sys_freq(). See:

http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80

We need a quick fix and we could take the occasion to establish a common
function for the MPC52xx as well, but it's not obvious to me how to find
the SOC node without the device type property.

Wolfgang.
