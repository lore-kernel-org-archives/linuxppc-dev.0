Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id D1D9767E34
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 00:50:23 +1000 (EST)
Message-ID: <42F0D9AD.70508@ru.mvista.com>
Date: Wed, 03 Aug 2005 18:50:21 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: pantelis.antoniou@gmail.com
References: <42EF9022.5050707@ru.mvista.com>
	<200508030039.16107.pantelis.antoniou@gmail.com>
	<42F06F62.6050509@ru.mvista.com>
	<200508031914.10973.pantelis.antoniou@gmail.com>
In-Reply-To: <200508031914.10973.pantelis.antoniou@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------030904080400070103000702"
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] cpm_uart: Made non-console uart work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030904080400070103000702
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>Well, all the stuff works on 8272 even without this and likewise stuff,
>>but don't on 866ADS, where bus_to_virt returns value not equal to where
>>we allocated DMA. I didn't dig too deep to track why this happens, since
>>if we're using DMA, we should remember addresses upon allocation and
>>avoid using bus_to_virt.
>>    
>>
>
>Well, this is weird cause I've tested my latest patch on 8xx and had no 
>problems...
>
>  
>
Since currently I have no ability to reproduce this issue, I'm inclined 
to drop those hunks. BTW, why those bus_to_virt and virt_to_bus are 
used? Isn't it more clear to use pure addresses if they are dma-allocated?

>I'll try to test your patch, some time later today.
>
>However, what is important now is to get the fs_enet driver posted.
>Please test the latest patch I've send you on a linus tree and report if you
>have any problems...
>
>  
>
I'll try to test it today/tomorrow as time permits...  But do you think 
it can proceed with those mii issues? Though they are almost harmless, 
the driver will complain that no PHY found but all seem to work fine 
subsequently. As far as Andy's phy will likely to be in rc14, maybe we 
can try to push this upstream (as what we have currently for 82xx and 
especially for 8xx is IMO worse than even incomplete implementation). 
I'll try to  investigate mii troubles, but it's hard to estimate efforts...

>Regards
>
>Pantelis
>
>
>  
>


-- 
Sincerely, 
Vitaly


--------------030904080400070103000702
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid200508031914.10973.pantelis.antoniou@gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">Well, all the stuff works on 8272 even without this and likewise stuff,
but don't on 866ADS, where bus_to_virt returns value not equal to where
we allocated DMA. I didn't dig too deep to track why this happens, since
if we're using DMA, we should remember addresses upon allocation and
avoid using bus_to_virt.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, this is weird cause I've tested my latest patch on 8xx and had no 
problems...

  </pre>
</blockquote>
Since currently I have no ability to reproduce this issue, I'm inclined
to drop those hunks. BTW, why those bus_to_virt and virt_to_bus are
used? Isn't it more clear to use pure addresses if they are
dma-allocated?<br>
<blockquote cite="mid200508031914.10973.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap="">I'll try to test your patch, some time later today.

However, what is important now is to get the fs_enet driver posted.
Please test the latest patch I've send you on a linus tree and report if you
have any problems...

  </pre>
</blockquote>
I'll try to test it today/tomorrow as time permits...  But do you think
it can proceed with those mii issues? Though they are almost harmless,
the driver will complain that no PHY found but all seem to work fine
subsequently. As far as Andy's phy will likely to be in rc14, maybe we
can try to push this upstream (as what we have currently for 82xx and
especially for 8xx is IMO worse than even incomplete implementation).
I'll try to  investigate mii troubles, but it's hard to estimate
efforts... <br>
<blockquote cite="mid200508031914.10973.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap="">Regards

Pantelis


  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Sincerely, 
Vitaly
</pre>
</body>
</html>

--------------030904080400070103000702--
