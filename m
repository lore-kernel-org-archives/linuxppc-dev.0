Return-Path: <fengguang.wu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qpgGk2s4FzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 06:48:46 +1000 (AEST)
Date: Tue, 19 Apr 2016 04:47:28 +0800
From: kbuild test robot <lkp@intel.com>
To: Jack Miller <jack@codezen.org>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 anton@samba.org
Subject: Re: [PATCH 2/3] powerpc: Load Monitor Register Support
Message-ID: <201604190414.NkLxbSQl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <1461006482-20595-3-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jack,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.6-rc4 next-20160418]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jack-Miller/powerpc-Complete-FSCR-context-switch/20160419-031650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/process.c: In function 'start_thread':
>> arch/powerpc/kernel/process.c:1615:17: error: 'struct thread_struct' has no member named 'fscr'
     current->thread.fscr &= ~FSCR_LM;
                    ^

vim +1615 arch/powerpc/kernel/process.c

  1609		if (cpu_has_feature(CPU_FTR_TM))
  1610			regs->msr |= MSR_TM;
  1611		current->thread.tm_tfhar = 0;
  1612		current->thread.tm_texasr = 0;
  1613		current->thread.tm_tfiar = 0;
  1614	#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> 1615		current->thread.fscr &= ~FSCR_LM;
  1616	}
  1617	EXPORT_SYMBOL(start_thread);
  1618	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ew6BAiZeqk4r7MaW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJxGFVcAAy5jb25maWcAjFxbk9s4rn6fX6GaOQ+ZqjNJXzNJneoHmqIsxrqFpGx3XlSO
W0lc6bZ7bfdM8u8PQMq2LqCzWzW1aQLiBQSBDyDoP377I2Av+83TYr9aLh4ffwZf63W9Xezr
h+DL6rH+vyDMgyw3gQileQ3MyWr98uPN8+bfevu8DG5ev3198dd2eR1M6u26fgz4Zv1l9fUF
Olht1r/9AR/wPIvkuCoK/vYmWO2C9WYf7Or9b5ZYbDfLerfbbIPdy/PzZruH1tMH1SjPJ9e6
ur66+9npqXp3++NHu7Mu0UO7ufC039Dt4uriok0YTAxm1bS9/fHj9AcyREXZnjNLjJwK7ulN
m7BK07LbQ9NILD5NK51ILrSnu5hNRVXAp7osilyZ9vc6LbxyC/NcjUSSEN1OQ53biTR/86Ks
RiiiLJQs60y8zXZ9NZLm9OcsV2Gl5Sdxd33Vko3icVXE97piYagqU729ga/IWVrWMGVezobP
CfP4mRWIFqYsqkIoO3mmBCOHyIQIj1wiHcFfkVTaVDwuswkxVqYqqT7qu9vLq0OTNoxPjGJc
tLagoblm+CJK2FgP6UnOJ6EohgQ10yKt5jwew+JBoca5kiZOTwxWODHTlUzy8VVVtjdiLDKh
JKjGTMhxbIiPUKogoornsVAiM1XK9KSzsW2JHvrjukwJmQimkvuqUDIz7T5YBp8YmYq8NHeX
7y76s8umirUWpHkM0s9TaaoICKDTOXQoVG/2KbtvVB6OXcj7p6UMR+Pq8u3t7QW534exzUjf
Z9QBZSVYPjtSu2dRsEKhGaAVNRQRKxNTlTJlY0H1auUuR0JlzMg8g7VpLUeJ6E8/5KpClqnw
n1tgSVOZ+4ZpVAn2WIxK3IaxYAnoWU+OR7ayUPlItKxbMTYMplYlYioSfXfUc1jlQWulNne/
v3lcfX7ztHl4eax3b/6nzHDPlEgE0+LN66X1DL87uz+2TuYRp/ryfLL5I5VPRFaBOMBOncaX
GeyAyKYwTxwKFAINyMEUKZAcqG1aSJDe77+fZNO0VUZoykiABFgyFUqD+DvftQmw/YYS7GGD
41wbXOfd76/Wm3X9Z6sbfa+nsuDktrlJpyLN1X3FDNiLmOSLYpaFCb31pRaJHBFzs4fBbqnV
XZgHrCcBcVrRg+kBZ/t593O3r59Ooj+cAyBXOs5nQ9txoDg1aO0OtId5ymTWbYtyxeH8mhhM
bSizcetgF0xpawSHo6B5qKbNnKs8CYcsHG0kzCEzmiCmOWpwyIw4rNisnurtjlp0/AlNvcxD
2TEbWY4U6RO8JZOUGIwraLy2q1B6AHfAp7wxi933YA9TChbrh2C3X+x3wWK53Lys96v119Pc
jOQT56o4z8vMOAnabhQvAz1cDbDcV0BrLwX+rMQcFknbKQNGXiMTScWPwZfBPsBRSvOM7kIJ
YTmtZ/P2g5MAZRR+mzkqZRICqsiu6DMjJ+4f9IEaq7wsNE2LBZ9Y34F7Y3JFz9K5Gzzvti96
JSJh9/TskwkYham1VSqk58GrvADNAACEh8MiIeL4ou6bBATGRWFdgxXsSdPddrY3OQVLJMEc
KHpdY2HQmVfNoaKZ7nWkz3JMgKDvU1rEB2LFRjpPSthmmCMoL+2zLC7w6AC9vSNwIVVUeqYW
wYBzGsIXuW/BcpyxJKJ3yh5fD80aHg9tVETnpRyDyaeRbdd9n9rDqYSlN53Swsedt97IM6uC
y+pjKdWE/hymNGJKya76HFaLCDgULSvsoBaMWB1NsDVKTQBY1Nsvm+3TYr2sA/FPvQbrxsDO
cbRvYIU7IeGpE3Ji09RRK2v/eva04+WZAehAa5ROGOUjdVKOOnFRko98B8MA7gZ/wirABDKS
3AI2j2bnkUzAUvu8cu44OijvQ5kWFcxS0DrToDHa32CfNgiCgAAUGu0Xh8CQigwtr4hg/hJl
Cuis80UPDIJOWYMMPqUa6RkregogwYqmrMAVmx5p0oePrlUJQxLscNbExRBUDx06IEHrihsg
0ftaCQiiACO5mKtZS8UK2eOzQWMhHQSmZnDahUFwBCxZKivNIgHwosAQrMczYyBRwHqVAzYH
UEkMowVHhYWYMnGRTNs72DWgRAUHL+XbwzQPm74KwVEfT+MAqUwAfuDuiSSy7qq/cYDMxBwU
BhyLRXQ4JhEP2s9BsDm6q1bgn+QZaAZ8M2MqbO0lIDW0qbqEWWXhoJ1x4yTi4D/Pp399Xuzq
h+C7MxvP282X1WMHAB2ngtzN0QIpWiTbPQEHVcFNPsSvhPSsE9Ep9nDZMn9OZh6nDkiT6Elm
cMihrwJOR5khUxfMNnTU14Z+jkZ+O1MIljwft4ndr7uRHDOwfbxS6awtswgQ2ycPWMB4ci45
LQ4kSl78Kh5Flnh6hgyIE4CnJxyvomLcSc24ROHjYo9+pZUn7HTKY+VPbKUFv7288icMkX51
JqFYpIyGpHZk4XH2B+KvxPXOO/THKxb6d+Ld9bkc6FsP8eDQfXSWwmGFM07DPHDJ47IXTvdy
ImAC2VR64g2cWh7ZGABtfgrwTHrGkoWkhZ76CNi5m0MM9uLM19VMSA9Gtwr67ur2vZfqVV1M
wbgUln/g8rqKjc0XnlPGy4u3XvL7vy9Aofy6XvzdJx8izyDa1v95qdfLn8FuuWhs7cn9QKQJ
huEj9aV8eKyDh+3qn3oLTcf+sLnfhTdotoYJk6v6yIe4rkiEB4IzOniIdFKViby8/fvWg+tT
6LMaF11A3Yaom2e8nOhAUQzcfdA8/lRdkhcBQLi6veh4o0/V9QWdZ3S90N3cQTf9ODRWmACg
MvxgvdPCVBkc0k6ysGmfQvyVGaboMLXhoryjzKLUoN9v99q0aq5kQR9ph23y0hPUu+9TqT2J
MMCRYem5lJA5XoDEIil8oe1M5iah8L1VN5HZtGWTZotzUyRlH7ohwJgxCN4dV4866AFQbz7t
yH0i5sKX5GM6rvqra3cfJcxA380wp7Gb9m4D7Hhop1KlAziOMVwXKXSam08Hnx2AEyZoxmWL
muXWRrs5dLe6aQcoEuW2Xyq6KhJAmIWxY8Nx13c3vYCNe2Mo8D/qTIR17p6o4fmEEBWxIF6x
ANQ7hJPglCoDCyt1Z/80dYNxyO+mGOSkAPNwzLubi/dvjyJqXxRNOnLiiWAZZ3COab1I6aun
T0We01Di06ikreQnC2dz8t6il/qPhIKjBnhfldzYSwCbq+peOt5MLKWF620WF1RnbsWaqxCi
lssWfLYoB8NaC6896w0tah31lneADXNAAmDv1VgY3UnEF9TOSM0O0dwhnBi97FpGvacFncQu
7hl+jLsKkY+hlNcy6bHlS0Q2NjGRC3eT6F/WyCyUSqB4uaRMN2+FpZiVcWlz3W085evbGRyB
+wiq683wpFp6aTbq9VKVuw46GLv+jUeHV5uSzpMgUeYe1A+0QvmnVzAtO/rtID/I8Ntmtw+W
m/V+u3l8rLcNCOlmkUA2VTirCjCRnhE486A9NP4KFCn0ZN/O0cD/ogaBMkyEyrrJGzs/9vAP
ZsEesMVecrWTemAf8G7TJniH9wRh/WXx8mgb8FJgF0DoEywO/S3bNRYHxQ8W2zp4gYj6dAKS
fIaG2l64X/wAYGL/d7qNBQuQR5EWBqjLHtWtCc+IoshohiVo6ZHhosdgbMLZjXz8uAsGXXaB
lq2g7LpzP0VUfbBmq5HUP6tlHYRHvThdL66WTXOQDwFf6TKLZ7BFKKYmLSL6wMGys5AlvjgJ
UJbtPpIQejPlUmm0CkYz2CcWeiaBB3Nm7xXOAiV3sRsqCDN9i7EMYqo8mQ4wOlV8D7KYSp3T
fRxv2MDfQU/9ApTTWFhJEDN0NqMyirozOtrrB7txnT1JTUjsemhaCa68A04hkizBhXnud4GK
sAnvp9odNMUJJAmdfCcXemrrGm9o76Rd4O8+3RrEHg90BBIGwfSAFZAAVare3VL7sKRYtnEs
c4AYu1/Y0zQNZJ2udktK2KBL6T1O0AOzWGY8h1OP0dLzG5JoZJRaXaUzBBlPcl0qrMZRfg2K
C6xhoQf3hdf8ily+EABNUipr5CjV+2s+p6NtPvr78mKwFnejXP9Y7AK53u23L0/2jmP3Dezv
Q7DfLtY7HCmA+BpiZhD+6hn/ebBM7HFfbxeBzXF9WW2f/kWz/bD5d/24WTwErnbiwCvXe4hW
U8ntgQk78bfmMiKap3lBtJ46itGf+oh8sX2ghvHyb56P5Xt6v9jXQbpYL77WKJHgFc91+mff
MOP8jt2dtoLH9G7zeXIGVgKxcVPgpr0sQsQ+XyLDY42A5gCf3DEZliIiEfPEnQsjbAs9SD4q
dS+AcaITQgSX1+9vglfRalvP4L8/KdUEtyFm0nOGDkQAIJqO8VPGJZxejD2tRxjiC7l+ftkP
l3sKvLOiHJ6lGPTD6qt8kwf4ScegaCyk+O/Ml2XtlJOxVJDHl8OxWiz3iPyGJswYev3gnHy5
HCBNfDRZpLJy9Ta0A4xnZzGLN/MHjrNShs4RsAJCZe7p0nD4jwyCYB19BzCXSXLfCxDcZl9x
co89ZRbac5Y0iIcWSzfwcNi90HSmfjg9bGtqjje2SufwlaOaIlg+bpbf+wSxXnx+rAMAolgE
haU0ABpnuZogNrUX+IDR0gLvYvcbGK0O9t9qwNAPK8SCi0fX6+51777J3uQ5WA7oFrOI0H1H
VV0TKYnZJe1M85lQNhRPPEk5y4DgwBPBWDqberzlzFuaEwuVMjqlMGOGx2FO3VRrPWqXIzr7
uFmvlrtArx5XEH4Eo8Xy+/PjYt3J/8J3VF6RAx7sdzfagrtbbp6C3XO9XH0BqM7SEWt3Nupl
SRyYgaBo9eVlvbSRT2O/iJgwjUI/CEEiptcSwIBi7jt7J6444aHnLgF4Yvn25uqyKtAhkrtj
uI1v+TVJTuyFGF38hzTtoeHQH1j2CevdfBEq8kxEWngiDySn5u31+7+9ZBXy66tLurTG0o2e
93MdHQad3l7Qh4KN5rcXQ3jV/fpec1+WEMhGViy9vr6dV0ZzdmaPTHpGQtP5u1v6KkGJcQlR
giccSkUo2SHBNtDU8Xbx/A1PDGEF2ZiO4qZjBkaINi2hSgdjMF4Er9jLw2oDUOz4kuJP/xsM
6AQkhhUfwwuiaLt4qoPPL1++gLMNh842oueFlQCJde5wSihptFc3yLidTEdeZlTwV4IpymOI
pBII8xIxeG+A9EGlPDYec/sx78C2smuj7AqxzWL2hy5Yxfbi288dPowJksVPOv+Eo4HL8eSI
CkufcyHp1BhSxywceyx/OaPFnqYebRep7t8btbIqWLvruVF2lTNyJEHSVBQqQsYP9QSaK1s9
1SYRb02wnT5YBot4mfbmD86lF1g5D6UufHWYpeeo2+y/Dw9PV1s4K9Tu4mcy99q4htyvvm8i
7+V2s9t82Qfxz+d6+9c0+PpSQ/hFWAQ4GONe1VgXcevn1dqioJ6KctuoNy9b2hE6D1Z4ntNA
hGArHcGJ/IIhNeXVeQ6T0ve1Im0YQC890YpMRjntY9wFoM/Gqvpps68xBqWWro0tlYLxFQT6
fPj189Pua1+eGhhfaVtXHeRrCD9Wz3+eMEpIjFJmc+nPSkB/lWfdRYoovn/lfpLb3Hh9n72N
pAXmS1Yb2o5AoFR5LxVm5PWL+shj2boqZOBUxmAU8IooU+3KKllgSZ6vewt3wf9nRuWJL+SK
0uHGobFtV78PEpQ+a4yBQTFn1dW7LMWoxVNF0uYC80zrPcDTagIxguXwj4jAnXuqNVI+dEXt
6tkngNz7zsvIk+w8JSgmBjcq1ChPhqeFrR+2m9VDxzpkocoljQ4zbwytjSd+zgzYGhMPRrbJ
rg4ogf0bJj2osq9oBTGe2+kuGtEYUsg5uC1PSTjWCuL1c8+stnrIciMjTwbhDE06WuWtt4/Y
ma8/lrmhc0aWwg29HLyTi/RN5bmOiLDg00NrEss9shPmYvmth/L04Nra6eWufnnY2BfBxG6g
ffUNb2lgMZJQCdqcYQ7Pd82CrxLosKoEyJSM7C0WyeD+D/TE0wFWpFgtcQXeNFPmqbgfyYyp
5oFjNBBWsvq8XWx/BtvNy361rlt30iNp8GZI6U4Fyak6+EQnLO+xINqojBewoZi+Ri0kaqaB
JRGZh+quajvVIMd77U5ajivYOg7Im5aw4peezDl8Zy4vQhl5ydKUFXVpA7Tug2fbUGmRRJ5r
noYBH0SP7t8RnzoKfV3RsDA180UmjsP3IBmodPScyJH90lcZxN95zvnhsenhXUOzM7QLtdlI
j3iOXPNPADToDhwJnNkHQrD2KXHeKUNyTQjG+sVEuimH6OmTCxje3hBFVweSnYGMrD3HOtnO
DuYq9Kw9DGnrizXt/Uc/pz2Jwu5r+KZUiWA+zlPjAzL3uLFdRPhtsfzuSiht6/N2td5/t3nI
h6cagOWgHiWF8Aqv3JN8bB9QHkqM7m4aY7x5egbz+pd9Ggh2efl9Z7tbuvYtVbbornWxEovG
kK6gY8ZUBqyFEhy03POqqSl0K+1Ld0FWHrpH2Njb3eXF1U0bEShZVEynlfeBGJa7u+oSTaOH
MgNjhSmfFNCLx5XYioVZdvaOu2vuD/op8IZdu5W1FcB9o4UtR0OfkGJalPZFPSYn1jzz5HSb
2djqqZlgk0OpmCcGQgQNnqh7Hdvpyl11HbQwhdgHXExYf375+rVXymvlBPGDyPq3UL3ZHV+C
+8Vd5FLnmQ9EuW7y0QeQjffNUTN9MCQJyGEo/QPlzAjucU+pfc7ecU19dz5IbEo4seTt/ETt
WAiaoiSfEbrSJp+bcty7W2/KVWC/ggSC9pdnd7zjxfpr50wjaC0L6GX4Cqg1BBIBBGWu0oZk
mn0kk/yt/cWfYwCNzvOC2rwOvZqypBR3gzJlr+1xZLdxIguHRqUnL0wSTIQoqDQIyuuk6sGr
XZMN2f1v8PSyr3/U8I96v3z9+vWfQ+uIj3T6z3j6uoHvR33VLJZjNnNM+E5wBm6ZNhGO1xa9
njlWCrTnbGhiO8Bc6ZlBDpm4BET2i7nAMPbp2wEk0Ou0g4K+GazO8GKJ0y+bnBl04gzCuWlJ
T/+NXZK/4tDn7JENv6Tvvajj4UqEIjOSJcOwCJ/D04bVbp3vtXzzqwZYS938UAkdo/9KxvYt
/X/FdP7B/Ud9pu6zUevmVxoq5fdNB2lWQqlcwYH/IPzF265omuRpW9qozPjpabu6+0lTx4oV
Mc0T3mcMD0DUexzvOnA/spPad8MAPRBG9lgOPzBhOe12taq+sBFPDZHTjgZCdyqDv94AuM3U
u31PaXALrTpX2nc1Mjr9XBA+u/Rv+sj+2IKXfoTUZ+MBO6FYzL3VhJYBMV02bgokPdkm5JsA
o/Gkby3DMEju0iG0Sj0ZMktXAMJj+/szhDa534wIc65V5xc8Os99/X2Xoff3HAAv+K0gwzdG
XsBjQ4fJOOzUDeDf58KMcqRZBj0DPsHfh+gVgFvquc9dzUsltSsZFd1aJdhLgAtn6mLszwhJ
7cIFe9ApQFDwhkh0nqaVuS+EdfMkmkA1aPAAxCImvnvbiiA4vk8pEK3Yc3dOfeEEVpGcA0Q6
y5b+/4I9oUmLQO8Y1+IJJxdP0P4iXN0B0DaYCGAqisC90RGy0BQjCUImGlKTS4sySyqx9eq8
XSNxDIe5OocGeYYAzQR2JsEj6OCwx6sWa38ItrsFYaAj0iJbdFnUQ5WCIgNw7A8ATYaFOvp4
RmFs3wEAMdonrGZQAAA=

--ew6BAiZeqk4r7MaW--
