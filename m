Return-Path: <tmarri@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	by ozlabs.org (Postfix) with SMTP id E5DCAB702E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 02:44:30 +1000 (EST)
Received: by gwaa18 with SMTP id a18so820856gwa.19
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 05 May 2011 09:44:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1304487166.2513.351.camel@pasglop>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop>
	<1304487166.2513.351.camel@pasglop>
Date: Thu, 5 May 2011 09:44:27 -0700
Message-ID: <BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
From: Tirumala Marri <tmarri@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=20cf3011ded9243b4404a28a169e
Cc: linuxppc-dev@lists.ozlabs.org, Ayman El-Khashab <ayman@elkhashab.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf3011ded9243b4404a28a169e
Content-Type: text/plain; charset=ISO-8859-1

>
> Also, the patch removes the code for waiting for the link to be up with
> a comment "What DCR has the link status on the 460SX?". Please fix that
> (Tirumala, can you provide the missing information ?)
>

It is not one register. Here is the flow for Gen-1.
1. PECFGn_DLLSTA[3] will be asserted when pci-e link comes up.
2. now progream the UTL buffer configuration registers.
3. SW should assert PEUTLn_PCTL[0] to cause flow control initialization.
This is memory mapped using GPL register REGBH , REBAL and REGMSK
4. Now check for the PEUTLN_PSTA[8] for the flow control init completion.

--20cf3011ded9243b4404a28a169e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">Also, the patch =
removes the code for waiting for the link to be up with<br>
a comment &quot;What DCR has the link status on the 460SX?&quot;. Please fi=
x that<br>
(Tirumala, can you provide the missing information ?)<br></blockquote><div>=
<br></div><div>It is not one register. Here is the flow for Gen-1.</div><di=
v>1. PECFGn_DLLSTA[3] will be asserted when pci-e link comes up.</div>
<div>2. now progream the UTL buffer configuration registers.</div><div>3. S=
W should assert PEUTLn_PCTL[0] to cause flow control initialization. This i=
s memory mapped using GPL register REGBH , REBAL and REGMSK</div><div>4. No=
w check for the PEUTLN_PSTA[8] for the flow control init completion.</div>
<div><br></div><div><br></div></div>

--20cf3011ded9243b4404a28a169e--
