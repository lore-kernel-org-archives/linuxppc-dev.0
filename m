Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 41B48DE8B4
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 05:46:08 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1364903ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 12:46:02 -0700 (PDT)
Message-ID: <fa686aa40805121246i68c42867k150c5f9e0082598f@mail.gmail.com>
Date: Mon, 12 May 2008 13:46:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
In-Reply-To: <20080512191025.67682630064@mail160-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
	<20080512173130.0D747181804D@mail89-sin.bigfish.com>
	<fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
	<20080512191025.67682630064@mail160-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 12, 2008 at 1:10 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>  The best possibility that I see is glopping the compatibility
>  information about what cores are compatible with which drivers and
>  generating something.  This is moderately better than blindly treating
>  all cores with the same major version as interface compatible, but still
>  has the potential to blindly declare that core versions are compatible
>  when they are not really compatible.

That's okay, the device tree conventions provide for that uncertainty.
 If compatible includes both the *exact* version and the oldest known
*compatible* version (the one the drivers know about) then we're in
the situation where 99% of the time it just works.  For the 1% of the
time when mistakes are made we still have the necessary information to
write exceptions in the code to work around bad data.  This means code
only needs to changes when mistakes are discovered, not for every IP
core uprev.

>  I *really* don't want to put this into the device tree generator on a
>  case-by-case basis, so unless there is something that can be generated
>  from whatever meta-information EDK has, I think we're going to have to
>  just have the explicit versions in the drivers for the time being.

Can we post process the generated device tree with a table of known
compatibility strings (or regexps) for adding the older compatible
values?  I don't expect the list will be particularly long or hard to
maintain and the code to do so should be trivial.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
