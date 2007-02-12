Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 9CC26DDF3C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:44:19 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1374332ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2007 12:44:12 -0800 (PST)
Message-ID: <528646bc0702121244k6e2878behb935cdbb3d249039@mail.gmail.com>
Date: Mon, 12 Feb 2007 13:44:11 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Subject: Re: [RFC] mpc5200 device tree bindings refinement
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3029428D5@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11710062092006-git-send-email-grant.likely@secretlab.ca>
	<9696D7A991D0824DBA8DFAC74A9C5FA3029428D5@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/12/07, Yoder Stuart-B08248 <stuart.yoder@freescale.com> wrote:
>
> My suggestion would be to _not_ create a brand new property
> called system-frequency.  Could we not use the existing
> clock-frequency property instead (defined to mean the
> Fsystem frequency)?
>
> Currently across many device types (e.g. PCI, serial) the
> clock-frequency property is used to describe the clock
> frequency in a way specific to that device.  Could that work
> here?
>
> If you did need to create a new property unique to this
> particular device it should have the vendor name preprended
> to the property (e.g. linux,phandle).
>
> If this property is generally across all soc device types
> the "soc" section in booting_without_of.txt should
> be updated with a clear definition of what the property
> means.

Gah!  I just regenerated my patch and sent it about 5 minutes ago!
Your timing is impeccable.

I'm not too concerned about the name of this property.  It's pretty
much SoC specific regardless.  Every time a new soc is rolled, there
will be differences in how the frequency properties are interpreted.
In this case, this is not the external clock frequency, but rather the
internal frequency derived from the external clock.  I thought it best
to name the property after the actual signal name (fsystem).  Maybe it
would be best to rename this to "fsl,system-frequency" or
"fsl,fsystem-frequency"

Comments?
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
