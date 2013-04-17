Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C29082C0528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 22:38:48 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Wed, 17 Apr 2013 09:38:44 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id D68321DC004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 08:38:41 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3HCa6Nd2224158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 09:36:06 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3HAcPPk016654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 07:38:27 -0300
Message-ID: <516E97D0.5090708@linux.vnet.ibm.com>
Date: Wed, 17 Apr 2013 09:38:40 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCHv3 1/2] ppc64: perform proper max_bus_speed detection
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1365685994-32603-2-git-send-email-lucaskt@linux.vnet.ibm.com>
 <20130415050001.GA21147@concordia>
In-Reply-To: <20130415050001.GA21147@concordia>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 dri-devel@lists.freedesktop.org,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/15/2013 02:00 AM, Michael Ellerman wrote:
> On Thu, Apr 11, 2013 at 10:13:13AM -0300, Lucas Kannebley Tavares wrote:
>> On pseries machines the detection for max_bus_speed should be done
>> through an OpenFirmware property. This patch adds a function to perform this
>> detection and a hook to perform dynamic adding of the function only for
>> pseries.
>
> The crucial detail you didn't mention is that pcibios_root_bridge_prepare()
> already exists as a weak function in the PCI code and is called from
> pci_create_root_bus().

Adding this comment.

>
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 8bcc9ca..15796b5 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -430,6 +430,8 @@ static void pSeries_machine_kexec(struct kimage *image)
>>   }
>>   #endif
>>
>> +int pseries_root_bridge_prepare(struct pci_host_bridge *bridge);
>> +
>
> Don't do that, put it in a header where it belongs.
>

And done as well.

> cheers
>


-- 
Lucas Kannebley Tavares
Software Engineer
IBM Linux Technology Center
