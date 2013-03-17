Return-Path: <phileas-fogg@mail.ru>
Received: from smtp20.mail.ru (smtp20.mail.ru [94.100.176.173])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 051502C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2013 23:43:26 +1100 (EST)
Received: from [37.49.86.97] (port=55225 helo=[192.168.1.240])
 by smtp20.mail.ru with esmtpa (envelope-from <phileas-fogg@mail.ru>)
 id 1UHCvq-0007vB-1C
 for linuxppc-dev@lists.ozlabs.org; Sun, 17 Mar 2013 16:43:22 +0400
Message-ID: <5145BA3A.8080508@mail.ru>
Date: Sun, 17 Mar 2013 13:42:34 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Kernel panic on PowerMac G5 while scanning for SMU sensors
References: <5145B20C.2090104@mail.ru>
In-Reply-To: <5145B20C.2090104@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/17/2013 01:07 PM, Phileas Fogg wrote:
>
> I wanted to read the temperature sensors of my PowerMac G5 11,2.
> For that i installed the lm-sensors package, run 'sensors-detect'
> command and my Linux 3.8.2 kernel paniced in
>
> _smu_i2c_low_completion_
>
> with this message
>
> 'Unable to handle kernel paging request for data at address 0x00000008.'
>
> Regards
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

A further analysis showed that it crashes in _smu_i2c_complete_command_
which is called from _smu_i2c_low_completion_.

This line caused the panic:

list_del(&cmd->link);

regards
