Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 4A536B7C8E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 09:28:28 +1100 (EST)
Received: by ywh34 with SMTP id 34so7281716ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 15:28:26 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1269983680.7101.53.camel@pasglop>
References: <1269970878-5080-1-git-send-email-fkan@amcc.com>
	<1269982097.7101.52.camel@pasglop> <1269983680.7101.53.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 30 Mar 2010 16:28:06 -0600
Message-ID: <fa686aa41003301528w36550e40j417bedfae7da3de@mail.gmail.com>
Subject: Re: [PATCH] fix the problem where pcix node is probed again as pci
	node.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	Tirumala R Marri <tmarri@appliedmicro.com>,
	Feng Kan <fkan@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 30, 2010 at 3:14 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2010-03-31 at 07:48 +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2010-03-30 at 10:41 -0700, Feng Kan wrote:
>> > From: Feng Kan <fkan@appliedmicro.com>
>> >
>> > The current matching scheme make the pci node match to pcix or pciex node.
>> > To avoid the match, change the method so only one type of initialization
>> > is called per node.
>>
>> No, your patch is not right. The problem was introduced by a patch from
>> Grant that incorrectly made of_device_is_compatible do a substring
>> match. Grant should have fixed that now. Grant ? Is your fix upstream
>> yet ? If not, can you send that ASAP ?
>
> Better if I CC him too :-)

The fix is in upstream.  Commit 1976152fd8e706135deed6cf333e347c08416056

g.
