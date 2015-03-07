Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5C011A0198
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 20:37:10 +1100 (AEDT)
Message-ID: <54FAC10D.6080207@xenosoft.de>
Date: Sat, 07 Mar 2015 10:12:45 +0100
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Alex Perez <aperez@alexperez.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
References: <mailman.412.1425683254.7605.linuxppc-dev@lists.ozlabs.org>
 <49C58FDD-0206-4357-8CD2-46F3F7E4E739@alexperez.com>
In-Reply-To: <49C58FDD-0206-4357-8CD2-46F3F7E4E739@alexperez.com>
Content-Type: multipart/alternative;
 boundary="------------020906090503090308000605"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020906090503090308000605
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

I have a patch for it (Kernel 4.0-rc2):

diff -rupN linux-4.0/drivers/of/address.c 
linux-4.0-nemo/drivers/of/address.c
--- linux-4.0/drivers/of/address.c    2015-03-03 18:04:59.000000000 +0100
+++ linux-4.0-nemo/drivers/of/address.c    2015-03-03 22:34:00.037500744 
+0100
@@ -450,21 +450,6 @@ static struct of_bus *of_match_bus(struc
      return NULL;
  }

-static int of_empty_ranges_quirk(void)
-{
-    if (IS_ENABLED(CONFIG_PPC)) {
-        /* To save cycles, we cache the result */
-        static int quirk_state = -1;
-
-        if (quirk_state < 0)
-            quirk_state =
-                of_machine_is_compatible("Power Macintosh") ||
-                of_machine_is_compatible("MacRISC");
-        return quirk_state;
-    }
-    return false;
-}
-
  static int of_translate_one(struct device_node *parent, struct of_bus 
*bus,
                  struct of_bus *pbus, __be32 *addr,
                  int na, int ns, int pna, const char *rprop)
@@ -490,10 +475,12 @@ static int of_translate_one(struct devic
       * This code is only enabled on powerpc. --gcl
       */
      ranges = of_get_property(parent, rprop, &rlen);
-    if (ranges == NULL && !of_empty_ranges_quirk()) {
+#if !defined(CONFIG_PPC)
+       if (ranges == NULL) {
          pr_debug("OF: no ranges; cannot translate\n");
          return 1;
      }
+#endif /* !defined(CONFIG_PPC) */
      if (ranges == NULL || rlen == 0) {
          offset = of_read_number(addr, na);
          memset(addr, 0, pna * 4);

Rgds,

Christian

On 07/03/2015 01:16 a.m., Alex Perez wrote:
> On Mar 6, 2015, at 3:07 PM, linuxppc-dev-request@lists.ozlabs.org 
> <mailto:linuxppc-dev-request@lists.ozlabs.org> wrote:
>
>> Date: Sat, 07 Mar 2015 09:56:22 +1100
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org 
>> <mailto:benh@kernel.crashing.org>>
>> To: Steven Rostedt <rostedt@goodmis.org <mailto:rostedt@goodmis.org>>
>> Cc: Grant Likely <grant.likely@linaro.org 
>> <mailto:grant.likely@linaro.org>>, Rob Herring
>> <robh@kernel.org <mailto:robh@kernel.org>>, Olof Johansson 
>> <olof@lixom.net <mailto:olof@lixom.net>>,
>> linuxppc-dev@lists.ozlabs.org <mailto:linuxppc-dev@lists.ozlabs.org>, 
>> LKML <linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>>
>> Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after:
>> of/base: Fix PowerPC address parsing hack
>> Message-ID: <1425682582.4636.197.camel@kernel.crashing.org 
>> <mailto:1425682582.4636.197.camel@kernel.crashing.org>>
>> Content-Type: text/plain; charset="UTF-8"
>>
>> On Fri, 2015-03-06 at 10:00 -0500, Steven Rostedt wrote:
>>> On Fri, 06 Mar 2015 15:18:42 +1100
>>> Benjamin Herrenschmidt <benh@kernel.crashing.org 
>>> <mailto:benh@kernel.crashing.org>> wrote:
>>>
>>>
>>>> Can you shoot me the DT (/proc/device-tree in a tarball) ?
>>>
>>> Attached.
>>
>> This is indeed a bug in their DT. We might want to add quirks for
>> that unless it can be fixed (or has been via FW update). Olof ?
>
> I will of course ultimately defer to Olof, but PASemi hasn’t existed 
> for years, and there is no entity which could possibly update the DT 
> for these reference PASemi development boards, unless Olof has source, 
> which I’m pretty sure he does not :)


--------------020906090503090308000605
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi All,<br>
      <br>
      I have a patch for it (Kernel 4.0-rc2):<br>
      <br>
      diff -rupN linux-4.0/drivers/of/address.c
      linux-4.0-nemo/drivers/of/address.c<br>
      --- linux-4.0/drivers/of/address.c    2015-03-03
      18:04:59.000000000 +0100<br>
      +++ linux-4.0-nemo/drivers/of/address.c    2015-03-03
      22:34:00.037500744 +0100<br>
      @@ -450,21 +450,6 @@ static struct of_bus *of_match_bus(struc<br>
           return NULL;<br>
       }<br>
       <br>
      -static int of_empty_ranges_quirk(void)<br>
      -{<br>
      -    if (IS_ENABLED(CONFIG_PPC)) {<br>
      -        /* To save cycles, we cache the result */<br>
      -        static int quirk_state = -1;<br>
      -<br>
      -        if (quirk_state &lt; 0)<br>
      -            quirk_state =<br>
      -                of_machine_is_compatible("Power Macintosh") ||<br>
      -                of_machine_is_compatible("MacRISC");<br>
      -        return quirk_state;<br>
      -    }<br>
      -    return false;<br>
      -}<br>
      -<br>
       static int of_translate_one(struct device_node *parent, struct
      of_bus *bus,<br>
                       struct of_bus *pbus, __be32 *addr,<br>
                       int na, int ns, int pna, const char *rprop)<br>
      @@ -490,10 +475,12 @@ static int of_translate_one(struct devic<br>
            * This code is only enabled on powerpc. --gcl<br>
            */<br>
           ranges = of_get_property(parent, rprop, &amp;rlen);<br>
      -    if (ranges == NULL &amp;&amp; !of_empty_ranges_quirk()) {<br>
      +#if !defined(CONFIG_PPC)<br>
      +       if (ranges == NULL) {<br>
               pr_debug("OF: no ranges; cannot translate\n");<br>
               return 1;<br>
           }<br>
      +#endif /* !defined(CONFIG_PPC) */<br>
           if (ranges == NULL || rlen == 0) {<br>
               offset = of_read_number(addr, na);<br>
               memset(addr, 0, pna * 4);<br>
      <br>
      Rgds,<br>
      <br>
      Christian<br>
      <br>
      On 07/03/2015 01:16 a.m., Alex Perez wrote:<br>
    </div>
    <blockquote
      cite="mid:49C58FDD-0206-4357-8CD2-46F3F7E4E739@alexperez.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      On Mar 6, 2015, at 3:07 PM, <a moz-do-not-send="true"
        href="mailto:linuxppc-dev-request@lists.ozlabs.org">linuxppc-dev-request@lists.ozlabs.org</a>
      wrote:<br>
      <div><br class="Apple-interchange-newline">
        <blockquote type="cite"><span style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">Date: Sat, 07 Mar 2015
            09:56:22 +1100</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">From: Benjamin
            Herrenschmidt &lt;</span><a moz-do-not-send="true"
            href="mailto:benh@kernel.crashing.org" style="font-family:
            Helvetica; font-size: 12px; font-style: normal;
            font-variant: normal; font-weight: normal; letter-spacing:
            normal; line-height: normal; orphans: auto; text-align:
            start; text-indent: 0px; text-transform: none; white-space:
            normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">benh@kernel.crashing.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">To: Steven Rostedt &lt;</span><a
            moz-do-not-send="true" href="mailto:rostedt@goodmis.org"
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">rostedt@goodmis.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">Cc: Grant Likely &lt;</span><a
            moz-do-not-send="true" href="mailto:grant.likely@linaro.org"
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">grant.likely@linaro.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;, Rob Herring</span><br style="font-family:
            Helvetica; font-size: 12px; font-style: normal;
            font-variant: normal; font-weight: normal; letter-spacing:
            normal; line-height: normal; orphans: auto; text-align:
            start; text-indent: 0px; text-transform: none; white-space:
            normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">
          <span class="Apple-tab-span" style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; white-space: pre;"> </span><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&lt;</span><a moz-do-not-send="true"
            href="mailto:robh@kernel.org" style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">robh@kernel.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;, Olof Johansson &lt;</span><a
            moz-do-not-send="true" href="mailto:olof@lixom.net"
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">olof@lixom.net</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;,</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span class="Apple-tab-span" style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; white-space: pre;"> </span><a
            moz-do-not-send="true"
            href="mailto:linuxppc-dev@lists.ozlabs.org"
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">linuxppc-dev@lists.ozlabs.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">, LKML &lt;</span><a moz-do-not-send="true"
            href="mailto:linux-kernel@vger.kernel.org"
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">linux-kernel@vger.kernel.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">Subject: Re: [REGRESSION
            in 3.18][PPC] PA Semi fails to boot after:</span><br
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">
          <span class="Apple-tab-span" style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; white-space: pre;"> </span><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">of/base: Fix PowerPC address parsing hack</span><br
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">Message-ID: &lt;</span><a
            moz-do-not-send="true"
            href="mailto:1425682582.4636.197.camel@kernel.crashing.org"
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">1425682582.4636.197.camel@kernel.crashing.org</a><span
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; float: none; display: inline
            !important;">&gt;</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">Content-Type: text/plain;
            charset="UTF-8"</span><br style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <br style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">On Fri, 2015-03-06 at
            10:00 -0500, Steven Rostedt wrote:</span><br
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">
          <blockquote type="cite" style="font-family: Helvetica;
            font-size: 12px; font-style: normal; font-variant: normal;
            font-weight: normal; letter-spacing: normal; line-height:
            normal; orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">On Fri,
            06 Mar 2015 15:18:42 +1100<br>
            Benjamin Herrenschmidt &lt;<a moz-do-not-send="true"
              href="mailto:benh@kernel.crashing.org">benh@kernel.crashing.org</a>&gt;
            wrote:<br>
            <br>
            <br>
            <blockquote type="cite">Can you shoot me the DT
              (/proc/device-tree in a tarball) ?<br>
            </blockquote>
            <br>
            Attached.<br>
          </blockquote>
          <br style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">This is indeed a bug in
            their DT. We might want to add quirks for</span><br
            style="font-family: Helvetica; font-size: 12px; font-style:
            normal; font-variant: normal; font-weight: normal;
            letter-spacing: normal; line-height: normal; orphans: auto;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; widows: auto; word-spacing: 0px;
            -webkit-text-stroke-width: 0px;">
          <span style="font-family: Helvetica; font-size: 12px;
            font-style: normal; font-variant: normal; font-weight:
            normal; letter-spacing: normal; line-height: normal;
            orphans: auto; text-align: start; text-indent: 0px;
            text-transform: none; white-space: normal; widows: auto;
            word-spacing: 0px; -webkit-text-stroke-width: 0px; float:
            none; display: inline !important;">that unless it can be
            fixed (or has been via FW update). Olof ?</span></blockquote>
      </div>
      <br>
      <div>I will of course ultimately defer to Olof, but PASemi hasn’t
        existed for years, and there is no entity which could possibly
        update the DT for these reference PASemi development boards,
        unless Olof has source, which I’m pretty sure he does not :)</div>
    </blockquote>
    <br>
  </body>
</html>

--------------020906090503090308000605--
