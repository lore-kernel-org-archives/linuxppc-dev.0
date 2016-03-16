Return-Path: <runaway@candw.ms>
Received: from smtp618.redcondor.net (smtp618.redcondor.net [208.80.206.18])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ9GH6vFQzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 23:07:19 +1100 (AEDT)
Subject: Re: commit 9178ba294b6839eeff1a91bed95515d783f3ee6c an A-Eon Tabor
 Board
To: Alexander Graf <agraf@suse.de>
References: <56B1C97A.9010807@candw.ms> <56B26689.8060905@suse.de>
 <56B27BEE.9090503@candw.ms> <56B27D26.5080507@suse.de>
 <56B28509.2080303@candw.ms> <56B2866A.40202@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
From: Julian Margetson <runaway@candw.ms>
Message-ID: <56E949E8.9090402@candw.ms>
Date: Wed, 16 Mar 2016 07:56:24 -0400
MIME-Version: 1.0
In-Reply-To: <56B2866A.40202@suse.de>
Content-Type: multipart/alternative;
 boundary="------------060804000508080603040307"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060804000508080603040307
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/3/2016 6:59 PM, Alexander Graf wrote:
>
>
> On 02/03/2016 11:54 PM, Julian Margetson wrote:
>> On 2/3/2016 6:20 PM, Alexander Graf wrote:
>>>
>>>
>>> On 02/03/2016 11:15 PM, Julian Margetson wrote:
>>>> On 2/3/2016 4:43 PM, Alexander Graf wrote:
>>>>>
>>>>>
>>>>> On 02/03/2016 10:33 AM, Julian Margetson wrote:
>>>>>> Resending as it was attached to and old thread relating to a 
>>>>>> different motherboard.
>>>>>>
>>>>>> On 2/2/2016 9:54 AM, Julian Margetson wrote:
>>>>>>>
>>>>>>> Commit 9178ba294b6839eeff1a91bed95515d783f3ee6c prevents 
>>>>>>> building of kernel 4.1 branch on A-Eon Tabor Board.
>>>>>>>
>>>>>>> CC arch/powerpc/math-emu/fsqrt.o
>>>>>>> arch/powerpc/platforms/85xx/tabor.c:194:2: error: unknown field 
>>>>>>> ‘power_off’ specified in initializer
>>>>>
>>>>> I can't seem to find that file in Linux upstream?
>>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>
>>>>
>>>> It may have been discontinued as the patches used were maintained 
>>>> along with patches for the (Varisys)  A-Eon Cyrus board
>>>> which is officially supported from kernel 4.4.
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c383ee84e1d575b09d167185d15df24bde25eb15 
>>>>
>>>
>>> I don't quite understand how an internal API change in Linux 
>>> breaking random external patches is a bug? Either your code is 
>>> upstream or it can break on every git commit done upstream.
>>>
>>>
>>> Alex
>>>
>>>
>>>
>>
>> Sorry I am relatively new at this.
>> If I manage to pinpoint a problem on my powerpc machines I report it 
>> . Most of them so far have indeed been bugs.
>> The random external patches were done by person with far greater 
>> competence than me who are no longer in the picture.
>> Any  guidance would be greatly  appreciated.
>
> I think the most important step really is to upstream board support, 
> otherwise things will continue to fall apart for sure.
>
> As for the exact breakage you saw, just remove the line and put a line 
> like
>
>   pm_power_off = tabor_power_off;
>
> in your board probe function in tabor.c.
>
>
> Alex
>
>
>

Could not get it to work with the
  pm_power_off = tabor_power_off;


so resorted to the option below and it builds and boots (Tested Kernel 
4.5.0).
shuts down but no power off.
Can live with that for now.


Thanks for your help .


Regards
Julian


define_machine(tabor) {
.name= "Tabor",
.probe= tabor_probe,
.setup_arch= tabor_setup_arch,
.init_IRQ= tabor_pic_init,
#ifdef CONFIG_PCI
.pcibios_fixup_bus= fsl_pcibios_fixup_bus,
.pcibios_fixup_phb= fsl_pcibios_fixup_phb,
#endif
.get_irq= mpic_get_irq,
.restart= fsl_rstcr_restart,
.calibrate_decr= generic_calibrate_decr,
.progress= udbg_progress,
};


--------------060804000508080603040307
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 2/3/2016 6:59 PM, Alexander Graf
      wrote:<br>
    </div>
    <blockquote cite="mid:56B2866A.40202@suse.de" type="cite">
      <br>
      <br>
      On 02/03/2016 11:54 PM, Julian Margetson wrote:
      <br>
      <blockquote type="cite">On 2/3/2016 6:20 PM, Alexander Graf wrote:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 02/03/2016 11:15 PM, Julian Margetson wrote:
          <br>
          <blockquote type="cite">On 2/3/2016 4:43 PM, Alexander Graf
            wrote:
            <br>
            <blockquote type="cite">
              <br>
              <br>
              On 02/03/2016 10:33 AM, Julian Margetson wrote:
              <br>
              <blockquote type="cite">Resending as it was attached to
                and old thread relating to a different motherboard.
                <br>
                <br>
                On 2/2/2016 9:54 AM, Julian Margetson wrote:
                <br>
                <blockquote type="cite">
                  <br>
                  Commit 9178ba294b6839eeff1a91bed95515d783f3ee6c
                  prevents building of kernel 4.1 branch on A-Eon Tabor
                  Board.
                  <br>
                  <br>
                  CC arch/powerpc/math-emu/fsqrt.o
                  <br>
                  arch/powerpc/platforms/85xx/tabor.c:194:2: error:
                  unknown field ‘power_off’ specified in initializer
                  <br>
                </blockquote>
              </blockquote>
              <br>
              I can't seem to find that file in Linux upstream?
              <br>
              <br>
              <br>
              Alex
              <br>
              <br>
              <br>
              <br>
            </blockquote>
            <br>
            It may have been discontinued as the patches used were
            maintained along with patches for the (Varisys)  A-Eon Cyrus
            board
            <br>
            which is officially supported from kernel 4.4.
            <br>
            <br>
            <a class="moz-txt-link-freetext" href="https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c383ee84e1d575b09d167185d15df24bde25eb15">https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c383ee84e1d575b09d167185d15df24bde25eb15</a>
            <br>
          </blockquote>
          <br>
          I don't quite understand how an internal API change in Linux
          breaking random external patches is a bug? Either your code is
          upstream or it can break on every git commit done upstream.
          <br>
          <br>
          <br>
          Alex
          <br>
          <br>
          <br>
          <br>
        </blockquote>
        <br>
        Sorry I am relatively new at this.
        <br>
        If I manage to pinpoint a problem on my powerpc machines I
        report it . Most of them so far have indeed been bugs.
        <br>
        The random external patches were done by person with far greater
        competence than me who are no longer in the picture.
        <br>
        Any  guidance would be greatly  appreciated.
        <br>
      </blockquote>
      <br>
      I think the most important step really is to upstream board
      support, otherwise things will continue to fall apart for sure.
      <br>
      <br>
      As for the exact breakage you saw, just remove the line and put a
      line like
      <br>
      <br>
        pm_power_off = tabor_power_off;
      <br>
      <br>
      in your board probe function in tabor.c.
      <br>
      <br>
      <br>
      Alex
      <br>
      <br>
      <br>
      <br>
    </blockquote>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <p class="MsoPlainText"><br>
      Could not get it to work with the<br>
       pm_power_off = tabor_power_off;</p>
    <p class="MsoPlainText"><br>
      so resorted to the option below and it builds and boots (Tested
      Kernel 4.5.0).<br>
      shuts down but no power off.<br>
      Can live with that for now. <br>
    </p>
    <p class="MsoPlainText"><br>
      Thanks for your help .<br>
    </p>
    <p class="MsoPlainText"><br>
      Regards<br>
      Julian<br>
      <br>
    </p>
    <p class="MsoPlainText"><br>
      define_machine(tabor) {<br>
      <span style="mso-tab-count:1">     </span>.name<span
        style="mso-tab-count:
        3">             </span>= "Tabor",<br>
      <span style="mso-tab-count:1">     </span>.probe<span
        style="mso-tab-count:
        3">                  </span>= tabor_probe,<br>
      <span style="mso-tab-count:1">     </span>.setup_arch<span
        style="mso-tab-count:
        2">       </span>= tabor_setup_arch,<br>
      <span style="mso-tab-count:1">     </span>.init_IRQ<span
        style="mso-tab-count:
        2">         </span>= tabor_pic_init,<br>
      #ifdef CONFIG_PCI<br>
      <span style="mso-tab-count:1">     </span>.pcibios_fixup_bus<span
        style="mso-tab-count:1">      </span>= fsl_pcibios_fixup_bus,<br>
      <span style="mso-tab-count:1">     </span>.pcibios_fixup_phb<span
        style="mso-spacerun:yes">      </span>= fsl_pcibios_fixup_phb,<br>
      #endif<br>
      <span style="mso-tab-count:1">     </span>.get_irq<span
        style="mso-tab-count:
        2">          </span>= mpic_get_irq,<br>
      <span style="mso-tab-count:1">     </span>.restart<span
        style="mso-tab-count:
        2">          </span>= fsl_rstcr_restart,<br>
      <span style="mso-tab-count:1">     </span>.calibrate_decr<span
        style="mso-tab-count:2">         </span>=
      generic_calibrate_decr,<br>
      <span style="mso-tab-count:1">     </span>.progress<span
        style="mso-tab-count:
        2">         </span>= udbg_progress,<br>
      };<br>
    </p>
    <meta name="ProgId" content="Word.Document">
    <meta name="Generator" content="Microsoft Word 11">
    <meta name="Originator" content="Microsoft Word 11">
    <link rel="File-List"
href="file:///C:%5CUsers%5CJULIAN%7E1%5CAppData%5CLocal%5CTemp%5Cmsohtml1%5C01%5Cclip_filelist.xml">
    <!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" LatentStyleCount="156">
 </w:LatentStyles>
</xml><![endif]-->
    <style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-font-family:"Times New Roman";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
  </body>
</html>

--------------060804000508080603040307--
