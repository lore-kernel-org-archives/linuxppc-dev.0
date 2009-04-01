Return-Path: <mlcreech@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 42A19DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 05:53:57 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so118539yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Apr 2009 11:53:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5ee96a840903311522t10af5c64n53ab6f834ad475ff@mail.gmail.com>
References: <5ee96a840903311330y36ed97bet92319da8d118086@mail.gmail.com>
	<49D280E0.9020701@mlbassoc.com>
	<5ee96a840903311403r331943d2wf9dbb16491f6bc3@mail.gmail.com>
	<49D28A7E.2090703@mlbassoc.com>
	<5ee96a840903311522t10af5c64n53ab6f834ad475ff@mail.gmail.com>
Date: Wed, 1 Apr 2009 14:53:55 -0400
Message-ID: <5ee96a840904011153qc052002i8c35229ca3e85c6c@mail.gmail.com>
Subject: Re: MPC83xx console : no output after handover
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turned out that the normally-initialized 8250 driver was getting
stomped on by my device tree's serial driver (which is also an 8250) -
apparently CONFIG_SERIAL_8250[_CONSOLE] and CONFIG_SERIAL_OF_PLATFORM
don't play well together.  Disabling the latter fixed my problem.

Thanks for the help, and sorry for the noise.

-- 
Matthew L. Creech
