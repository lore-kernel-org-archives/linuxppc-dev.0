Return-Path: <pavius@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 488D21007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 09:52:27 +1000 (EST)
Received: by vws20 with SMTP id 20so2107855vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 16:52:23 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Apr 2011 02:52:22 +0300
Message-ID: <BANLkTik=ivFpWQEhqrVnYfr2LS4HSnTDuA@mail.gmail.com>
Subject: Non-console UART issues with 8xx
From: Eran Duchan <pavius@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=20cf307f370cd6f61c04a0e99d3a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf307f370cd6f61c04a0e99d3a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey list

I have a custom MPC875 board running 2.6.37. SMC1 is the console, SCC4 is a
general purpose UART (DTS is set up accordingly). No hardware or software
flow control for either.

The issue is simple: the non-console UART transmits garbled characters at
the end of the transmission. For example, set up SMC1 to console (works
perfect) and SCC4 as non-console, run stty -F /dev/ttyCPM1 19200 raw and
then echo -n 1234567890 > /dev/ttyCPM1 - transmission may be something like
"1234567=F8". Set the SCC4 as console (same baud rates) and the problem is
reversed (SCC4 works perfect, SMC1 transmit garbled).

Rx direction seems fine, after some rudementary testing.

I dived into the code and see that the console UART has a completely
different initialization sequence than the non-console UART. Short of divin=
g
into this ancient CPM architecture - does anyone have an idea?

Thanks
Eran

--20cf307f370cd6f61c04a0e99d3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey list<div><br></div><div>I have a custom=A0MPC875=A0boa=
rd running 2.6.37. SMC1 is the console, SCC4 is a general purpose UART (DTS=
 is set up accordingly). No hardware or software flow control for either.</=
div>
<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><d=
iv><br></div><div>The issue is simple: the non-console UART transmits garbl=
ed characters at the end of the transmission. For example, set up SMC1 to c=
onsole (works perfect) and SCC4 as non-console, run stty -F /dev/ttyCPM1 19=
200 raw and then echo -n 1234567890 &gt; /dev/ttyCPM1 - transmission may be=
 something like &quot;1234567=F8&quot;. Set the SCC4 as console (same baud =
rates) and the problem is reversed (SCC4 works perfect, SMC1 transmit garbl=
ed). =A0</div>
<div><br></div><div>Rx direction seems fine, after some rudementary testing=
.</div><div><br></div><div>I dived into the code and see that the console U=
ART has a completely different initialization sequence than the non-console=
 UART. Short of diving into this ancient CPM architecture - does anyone hav=
e an idea?</div>
<div><br></div><div>Thanks</div><div>Eran</div><div><br></div><div><br></di=
v></div>

--20cf307f370cd6f61c04a0e99d3a--
