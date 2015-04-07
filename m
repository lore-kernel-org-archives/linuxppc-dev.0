Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1B501A0127
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 05:23:29 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YfZ5r-000pip-02
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Apr 2015 19:23:27 +0000
Date: Tue, 7 Apr 2015 12:22:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Message-ID: <20150407192212.GA6446@roeck-us.net>
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
 <20150407164439.GA4514@roeck-us.net> <55241C02.60103@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55241C02.60103@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cedric,

On Tue, Apr 07, 2015 at 08:03:46PM +0200, Cedric Le Goater wrote:
> 
> on a P7  :
> 
> 	# ppc64_cpu --info
> 	Core   0:    0*    1*    2*    3* 
> 	Core   1:    4*    5*    6*    7* 
> 	Core   2:    8*    9*   10*   11* 
> 	Core   3:   12*   13*   14*   15* 
> 	Core   4:   16*   17*   18*   19* 
> 	Core   5:   20*   21*   22*   23* 
> 
How would the 'sensors' output look like on that system ?
Wouldn't it be something like the following ?

 	Core 0-7:    +29.0°C  
 	Core 4-11:   +29.0°C  

> 
> > Also, how do you know that the range of CPU IDs is always 8 ?
> 
> This is a shortcut. The code is for the ibmpowernv platform and assumes 
> that we are running on a P8 (8 hardware threads). It would be better to 
> use a "maximum threads per core" variable but I am not sure this is 
> available, as it is a tunable. I will look into it.
> 
Tunable how ? The core code must have some means to detect this number
when it initialized CPU entries, or am I missing something ?

Thanks,
Guenter
