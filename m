Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20030411115316.0416be20@mail.zultys.com>
Date: Fri, 11 Apr 2003 12:04:55 -0700
To: Ron Flory <ron.flory@adtran.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: parse error before `{', stray '\' in program
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5.1.0.14.2.20030411103728.03024f68@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:37 AM 4/11/2003, Ron Flory wrote:

>Wolfgang Denk wrote:
>>In message <3E96684D.7000601@imc-berlin.de> you wrote:
>>
>>>Does anyone know if the ppc_8xx-gcc 2.95.4 from DENX ELDK has this
>>>patch applied?
>>
>>
>>No, it has not, and will not.
>>
>>I see no sense in a modification that supports violations  of  the  C
>>standard.


Well, it doesn't violate any existing C/C++ standard:

This is excerpt from ISO/IEC 9899 (p. 9):

   5.1.1.2 Translation phases

     1 The precedence among the syntax rules of translation is specified
       by the following phases

         1. Physical source file multibyte characters are mapped,
            in an implementation-defined manner, to the source character set
            (introducing new-line characters for end-of-line indicators)
             if necessary.
             ....

         2. Each instance of a backslash character (\) immediately
            followed by a new-line character is deleted, splicing physical
            source lines to form logical source lines.
            ....

So, it's clearly implementation-defined behavior. In this sense both
preprocessor implementations (with or without patch) are standard compliant.

I think this trivial patch make more cleaner solution than any ugly makefile
hacks like dos2unix or tr or whatever... And definitely more user/developer
friendly.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
