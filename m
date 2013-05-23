Return-Path: <timur@tabi.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id ACB722C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 21:19:57 +1000 (EST)
Message-ID: <519DFB59.6090004@tabi.org>
Date: Thu, 23 May 2013 06:19:53 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 Nicolin Chen <b42378@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: fsl: expand the size of the name in fsl_ssi_private
 struct
References: <1369299072-25147-1-git-send-email-b42378@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7248@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7248@saturn3.aculab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: broonie@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Laight wrote:
>> strcpy(ssi_private->name, p) in probe() sets "name" by "p", gotten from dts,
>> >while the length of "p", if the devicetree node name of SSI is commonly set,
>> >would always be larger than 1 char size, so need a larger size for "name".
> Are you sure this isn't allowed for when the structure is allocated?
> Otherwise you also need to use strlcpy() as well.

Yes, this is already handled properly:

p = strrchr(np->full_name, '/') + 1;
ssi_private = kzalloc(sizeof(struct fsl_ssi_private) + strlen(p),
                       GFP_KERNEL);

Nicolin's patch is wrong.  Do not apply it.

-- 
Timur Tabi
